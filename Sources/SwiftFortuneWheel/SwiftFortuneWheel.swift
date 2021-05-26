//
//  SwiftFortuneWheel.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 5/28/20.
// 
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// Customizable Fortune spinning wheel control written in Swift.
public class SwiftFortuneWheel: SFWControl {
    
    /// Called when spin button tapped
    public var onSpinButtonTap: (() -> Void)?
    
    /// Callback for edge collision
    public var onEdgeCollision: ((_ progress: Double?) -> Void)?
    
    /// Callback for center collision
    public var onCenterCollision: ((_ progress: Double?) -> Void)?
    
    /// Callback for `wheelView` tap, returns selected index
    public var onWheelTap: ((_ index: Int) -> Void)?
    
    /// Turns on tap gesture recognizer for `wheelView`
    public var wheelTapGestureOn: Bool = false {
        didSet {
            setupWheelTapGesture()
        }
    }
    
    #if os(iOS)
    public var impactFeedbackOn: Bool = false {
        didSet {
            prepareImpactFeedbackIfNeeded()
        }
    }
    #endif
    
    public var edgeCollisionDetectionOn: Bool = false
    
    public var centerCollisionDetectionOn: Bool = false
    
    public var edgeCollisionSound: AudioFile? {
        didSet {
            edgeCollisionSound?.identifier = CollisionType.edge.identifier
            prepareSoundFor(audioFile: edgeCollisionSound)
        }
    }
    
    public var centerCollisionSound: AudioFile? {
        didSet {
            centerCollisionSound?.identifier = CollisionType.center.identifier
            prepareSoundFor(audioFile: centerCollisionSound)
        }
    }
    
    
    #if !os(macOS)
    /// `PinImageView` collision effect configurator
    public var pinImageViewCollisionEffect: CollisionEffect?
    #endif
    
    /// Wheel view
    private var wheelView: WheelView?
    
    /// Pin image view
    private var pinImageView: PinImageView?
    
    /// Spin button
    private var spinButton: SpinButton?
    
    /// Animator
    lazy private var animator: SpinningWheelAnimator = SpinningWheelAnimator(withObjectToAnimate: self)
    
    /// Animation helper for `pinImageView` collision effect
    lazy private var pinImageViewAnimator = PinImageViewCollisionAnimator()
    
    /// Customizable configuration.
    /// Required in order to draw properly.
    public var configuration: SFWConfiguration? {
        didSet {
            updatePreferences()
        }
    }
    
    /// List of Slice objects.
    /// Used to draw content.
    open var slices: [Slice] = [] {
        didSet {
            self.wheelView?.slices = slices
            self.animator.resetRotationPosition()
        }
    }
    
    /// Pin image name from assets catalog
    private var _pinImageName: String? {
        didSet {
            pinImageView?.image(name: _pinImageName)
        }
    }
    
    /// Spin button image name from assets catalog
    private var _spinButtonImageName: String? {
        didSet {
            spinButton?.image(name: _spinButtonImageName)
        }
    }
    
    /// Spin button background image from assets catalog
    private var _spinButtonBackgroundImageName: String? {
        didSet {
            spinButton?.backgroundImage(name: _spinButtonImageName)
        }
    }
    
    /// `wheelView` `Tap Gesture Recognizer
    private var wheelViewTapGesture: UITapGestureRecognizer?
    
    /// Audio player manager, used for collision effects sound
    private(set) lazy var audioPlayerManager = AudioPlayerManager()
    
    #if os(iOS)
    @available(iOS 10.0, iOSApplicationExtension 10.0, *)
    private(set) lazy var impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
    #endif
    
    /// Spin button title
    private var _spinTitle: String? {
        didSet {
            #if os(macOS)
            self.spinButton?.setTitle(self.spinTitle, attributes: configuration?.spinButtonPreferences?.textAttributes)
            #else
            self.spinButton?.setTitle(self.spinTitle, for: .normal)
            #endif
        }
    }
    
    /// Initiates without IB.
    /// - Parameters:
    ///   - frame: Frame
    ///   - slices: List of Slices
    ///   - configuration: Customizable configuration
    public init(frame: CGRect, slices: [Slice], configuration: SFWConfiguration?) {
        self.configuration = configuration
        self.slices = slices
        self.wheelView = WheelView(frame: frame, slices: self.slices, preferences: self.configuration?.wheelPreferences)
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.wheelView = WheelView(coder: aDecoder)
        super.init(coder: aDecoder)
        setup()
    }
    
    /// Setups views after init complete
    private func setup() {
        setupWheelView()
        setupPinImageView()
        setupSpinButton()
    }
    
    /// Setups snap animator for `pinImageView`
    private func setupSnapAnimator() {
        guard let pinImageView = self.pinImageView else { return }
        pinImageViewAnimator.prepare(referenceView: self, pinImageView: pinImageView)
    }
    
    #if os(macOS)
    public override var wantsDefaultClipping: Bool {
        return false
    }
    #endif
    
    #if os(tvOS)
    public override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        guard spinButton != nil else {
            super.pressesEnded(presses, with: event)
            return
        }
        for item in presses {
            if item.type == .select {
                onSpinButtonTap?()
            } else {
                super.pressesEnded(presses, with: event)
            }
        }
    }
    #endif
    
    /// Adds pin image view to superview.
    /// Updates its layouts and image if needed.
    private func setupPinImageView() {
        guard let pinPreferences = configuration?.pinPreferences else {
            self.pinImageView?.removeFromSuperview()
            self.pinImageView = nil
            return
        }
        if self.pinImageView == nil {
            pinImageView = PinImageView()
        }
        if !self.isDescendant(of: pinImageView!) {
            self.addSubview(pinImageView!)
        }
        pinImageView?.setupAutoLayout(with: pinPreferences)
        pinImageView?.configure(with: pinPreferences)
        pinImageView?.image(name: _pinImageName)
    }
    
    /// Adds spin button  to superview.
    /// Updates its layouts and content if needed.
    private func setupSpinButton() {
        guard let spinButtonPreferences = configuration?.spinButtonPreferences else {
            self.spinButton?.removeFromSuperview()
            self.spinButton = nil
            return
        }
        if self.spinButton == nil {
            spinButton = SpinButton()
        }
        if !self.isDescendant(of: spinButton!) {
            self.addSubview(spinButton!)
        }
        spinButton?.setupAutoLayout(with: spinButtonPreferences)
        DispatchQueue.main.async {
            #if os(macOS)
            self.spinButton?.setTitle(self.spinTitle, attributes: spinButtonPreferences.textAttributes)
            #else
            self.spinButton?.setTitle(self.spinTitle, for: .normal)
            #endif
            self.spinButton?.image(name: self._spinButtonImageName)
            self.spinButton?.backgroundImage(name: self._spinButtonBackgroundImageName)
        }
        spinButton?.configure(with: spinButtonPreferences)
        #if os(macOS)
        spinButton?.target = self
        spinButton?.action = #selector(spinAction)
        #else
        spinButton?.addTarget(self, action: #selector(spinAction), for: .touchUpInside)
        #endif
    }
    
    @objc
    private func spinAction() {
        onSpinButtonTap?()
    }
    
    /// Adds spin button  to superview.
    /// Updates its layouts if needed.
    private func setupWheelView() {
        guard let wheelView = wheelView else { return }
        self.addSubview(wheelView)
        wheelView.setupAutoLayout()
        setupWheelTapGesture()
    }
    
    /// Adds or removes tap gesture to/from `wheelView`
    private func setupWheelTapGesture() {
        if wheelTapGestureOn {
            if self.wheelViewTapGesture == nil {
                self.wheelViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(wheelTap))
                wheelView?.addGestureRecognizer(self.wheelViewTapGesture!)
            }
        } else {
            guard let wheelTapGesture = self.wheelViewTapGesture else { return }
            wheelView?.removeGestureRecognizer(wheelTapGesture)
            self.wheelViewTapGesture = nil
        }
    }
    
    #if os(macOS)
    public override func layout() {
        super.layout()
//        setupSnapAnimator()
    }
    #else
    override public func layoutSubviews() {
        super.layoutSubviews()
        setupSnapAnimator()
    }
    #endif
    
    #if os(macOS)
    public override var alignmentRectInsets: NSEdgeInsets {
        guard let layoutInsets = configuration?.alignmentRectInsets else {
            return super.alignmentRectInsets
        }
        return SFWEdgeInsets(top: layoutInsets.top, left: layoutInsets.left, bottom: layoutInsets.bottom, right: layoutInsets.right)
    }
    #endif
    
    /// Updates subviews preferences
    private func updatePreferences() {
        self.wheelView?.preferences = configuration?.wheelPreferences
        setupPinImageView()
        setupSpinButton()
    }
    
    /// `wheelView` Tap gesture method
    /// - Parameter gesture: Tap Gesture
    @objc private func wheelTap(_ gesture: UITapGestureRecognizer) {
        
        guard let wheelViewBounds = wheelView?.bounds else { return }
        
        guard !animator.isRotating else { return }
        
        /// Tap coordinates in `wheelView`
        let coordinates = gesture.location(in: self.wheelView)
        
        /// `wheelView` center position
        let center = CGPoint(x: wheelViewBounds.midX, y: wheelViewBounds.midY)
        
        /// `wheelView` start position offset angle
        let startPositionOffsetAngle = self.configuration?.wheelPreferences.startPosition.startAngleOffset ?? 0
        
        /// `wheelView` rotated position offset angle
        let rotationOffsetAngle = self.animator.currentRotationPosition ?? 0
        
        /// angle between tap point and `wheelView` center position
        let angle = coordinates.angle(to: center, startPositionOffsetAngle: startPositionOffsetAngle, rotationOffsetAngle: rotationOffsetAngle)
        
        /// slice index at tap point
        let sliceIndex = index(fromAngle: angle)
        
        onWheelTap?(sliceIndex)
    }
}

// MARK: - Slice Calculations Support

extension SwiftFortuneWheel: SliceCalculating {}

// MARK: - Audio and Impack Feedback Support

#if os(iOS)
extension SwiftFortuneWheel: ImpactFeedbackable {
    
    /// Impacts feedback if needed
    /// - Parameter type: Collision type
    fileprivate func impactFeedbackIfNeeded(for type: CollisionType) {
        switch type {
        case .edge:
            if edgeCollisionDetectionOn {
                impactFeedback()
            }
        case .center:
            if centerCollisionDetectionOn {
                impactFeedback()
            }
        }
    }
}
#endif

extension SwiftFortuneWheel: AudioPlayable {
    
    /// Impacts feedback and sound if needed
    /// - Parameter type: Collision type
    fileprivate func impactIfNeeded(for type: CollisionType) {
        
        #if !os(macOS)
        pinImageViewAnimator.movePinIfNeeded(collisionEffect: self.pinImageViewCollisionEffect, position: self.configuration?.pinPreferences?.position)
        #endif
        
        playSoundIfNeeded(type: type)
        
        #if os(iOS)
        impactFeedbackIfNeeded(for: type)
        #endif
    }
}

// MARK: - SpinningAnimatorProtocol

extension SwiftFortuneWheel: SpinningAnimatorProtocol {
    
    //// Animation conformance
    var layerToAnimate: SpinningAnimatable? {
        let layer = self.wheelView?.wheelLayer
        self.wheelView?.setAnchorPoint(anchorPoint: CGPoint(x: 0.5, y: 0.5))
        return layer
    }
    
    var sliceDegree: CGFloat? {
        return 360.0 / CGFloat(slices.count)
    }
    
    var edgeAnchorRotationOffset: CGFloat {
        return configuration?.wheelPreferences.imageAnchor?.rotationDegreeOffset ?? 0
    }
    
    var centerAnchorRotationOffset: CGFloat {
        return configuration?.wheelPreferences.centerImageAnchor?.rotationDegreeOffset ?? 0
    }
}

// MARK: - Public API (Animation)
public extension SwiftFortuneWheel {
    /// Rotates to the specified index
    /// - Parameters:
    ///   - index: Index
    ///   - animationDuration: Animation duration
    func rotate(toIndex index: Int, animationDuration: CFTimeInterval = 0.00001) {
        let _index = index < self.slices.count ? index : self.slices.count - 1
        let rotation = 360.0 - computeRadian(from: _index)
        guard animator.currentRotationPosition != rotation else { return }
        self.stopRotation()
        self.animator.addRotationAnimation(fullRotationsCount: 0,
                                           animationDuration: animationDuration,
                                           rotationOffset: rotation,
                                           completionBlock: nil)
    }
    
    
    /// Rotates to the specified angle offset
    /// - Parameters:
    ///   - rotationOffset: Rotation offset
    ///   - animationDuration: Animation duration
    func rotate(rotationOffset: CGFloat, animationDuration: CFTimeInterval = 0.00001) {
        guard animator.currentRotationPosition != rotationOffset else { return }
        self.stopRotation()
        self.animator.addRotationAnimation(fullRotationsCount: 0,
                                           animationDuration: animationDuration,
                                           rotationOffset: rotationOffset,
                                           completionBlock: nil)
    }
    
    
    /// Starts rotation animation and stops rotation at the specified rotation offset angle
    /// - Parameters:
    ///   - rotationOffset: Rotation offset
    ///   - fullRotationsCount: Full rotations until start deceleration
    ///   - animationDuration: Animation duration
    ///   - completion: Completion handler
    func startRotationAnimation(rotationOffset: CGFloat, fullRotationsCount: Int = 13, animationDuration: CFTimeInterval = 5.000, _ completion: ((Bool) -> Void)?) {
        
        DispatchQueue.main.async {
            self.stopRotation()
            self.animator.addRotationAnimation(fullRotationsCount: fullRotationsCount, animationDuration: animationDuration, rotationOffset: rotationOffset, completionBlock: completion, onEdgeCollision: { [weak self] progress in                        self?.impactIfNeeded(for: .edge)
                self?.onEdgeCollision?(progress)
            })
            { [weak self] (progress) in
                self?.impactIfNeeded(for: .center)
                self?.onCenterCollision?(progress)
            }
        }
    }
    
    /// Starts rotation animation and stops rotation at the specified index
    /// - Parameters:
    ///   - finishIndex: Finish at index
    ///   - fullRotationsUntilFinish: Full rotations until start deceleration
    ///   - animationDuration: Animation duration
    ///   - completion: Completion handler
    func startRotationAnimation(finishIndex: Int, fullRotationsCount: Int = 13, animationDuration: CFTimeInterval = 5.000, _ completion: ((Bool) -> Void)?) {
        let _index = finishIndex < self.slices.count ? finishIndex : self.slices.count - 1
        let rotation = 360.0 - computeRadian(from: _index)
        self.startRotationAnimation(rotationOffset: rotation,
                                    fullRotationsCount: fullRotationsCount,
                                    animationDuration: animationDuration,
                                    completion)
    }
    
    
    /// Starts indefinite rotation and stops rotation at the specified index
    /// - Parameters:
    ///   - finishIndex: Finish at index
    ///   - continuousRotationTime: Full rotation time in seconds before stops
    ///   - continuousRotationSpeed: Rotation speed
    ///   - completion: Completion handler
    func startRotationAnimation(finishIndex: Int, continuousRotationTime: Int, continuousRotationSpeed: CGFloat = 4, _ completion: ((Bool) -> Void)?) {
        let _index = finishIndex < self.slices.count ? finishIndex : self.slices.count - 1
        self.startContinuousRotationAnimation(with: continuousRotationSpeed)
        let deadline = DispatchTime.now() + DispatchTimeInterval.seconds(continuousRotationTime)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.startRotationAnimation(finishIndex: _index) { (finished) in
                completion?(finished)
            }
        }
    }
    
    
    /// Starts indefinite rotation and stops rotation at the specified index
    /// - Parameters:
    ///   - finishIndex: Finish at index
    ///   - continuousRotationTime: Full rotation time in seconds before stops
    ///   - continuousRotationSpeed: Rotation speed
    ///   - rotationOffset: Rotation offset
    ///   - completion: Completion handler
    func startRotationAnimation(finishIndex: Int, continuousRotationTime: Int, continuousRotationSpeed: CGFloat = 4, rotationOffset: CGFloat = 0, _ completion: ((Bool) -> Void)?) {
        let _index = finishIndex < self.slices.count ? finishIndex : self.slices.count - 1
        let rotation = 360.0 - computeRadian(from: _index) + rotationOffset
        self.startContinuousRotationAnimation(with: continuousRotationSpeed)
        let deadline = DispatchTime.now() + DispatchTimeInterval.seconds(continuousRotationTime)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.startRotationAnimation(rotationOffset: rotation) { (finished) in
                completion?(finished)
            }
        }
    }
    
    /// Starts continuos rotation animation
    /// - Parameter speed: Rotation speed
    func startContinuousRotationAnimation(with speed: CGFloat = 4) {
        self.stopRotation()
        self.animator.addIndefiniteRotationAnimation(speed: speed, onEdgeCollision: { [weak self] progress in
            self?.impactIfNeeded(for: .edge)
            self?.onEdgeCollision?(progress)
        })
        { [weak self] (progress) in
            self?.impactIfNeeded(for: .center)
            self?.onCenterCollision?(progress)
        }
    }
    
    /// Stops rotation animation
    func stopRotation() {
        self.animator.stop()
    }
    
    /// Starts rotation animation and stops rotation at the specified index and rotation angle offset
    /// - Parameters:
    ///   - finishIndex: finished at index
    ///   - rotationOffset: Rotation offset
    ///   - fullRotationsUntilFinish: Full rotations until start deceleration
    ///   - animationDuration: Animation duration
    ///   - completion: completion
    func startRotationAnimation(finishIndex: Int, rotationOffset: CGFloat, fullRotationsCount: Int = 13, animationDuration: CFTimeInterval = 5.000, _ completion: ((Bool) -> Void)?) {
        let _index = finishIndex < self.slices.count ? finishIndex : self.slices.count - 1
        let rotation = 360.0 - computeRadian(from: _index) + rotationOffset
        self.startRotationAnimation(rotationOffset: rotation,
                                    fullRotationsCount: fullRotationsCount,
                                    animationDuration: animationDuration,
                                    completion)
    }
}

// MARK: - Public API (IBInspectable)
public extension SwiftFortuneWheel {
    
    /// Pin image name from assets catalog, sets image to the `pinImageView`
    @IBInspectable var pinImage: String? {
        set { _pinImageName = newValue }
        get { return _pinImageName }
    }
    
    /// is `pinImageView` hidden
    @IBInspectable var isPinHidden: Bool {
        set { pinImageView?.isHidden = newValue }
        get { return pinImageView?.isHidden ?? false }
    }
    
    /// Spin button image name from assets catalog, sets image to the `spinButton`
    @IBInspectable var spinImage: String? {
        set { _spinButtonImageName = newValue }
        get { return _spinButtonImageName }
    }
    
    #if !os(macOS)
    /// Spin button background image from assets catalog, sets background image to the `spinButton`
    @IBInspectable var spinBackgroundImage: String? {
        set { _spinButtonBackgroundImageName = newValue }
        get { return _spinButtonBackgroundImageName }
    }
    #endif
    
    /// Spin button title text, sets title text to the `spinButton`
    @IBInspectable var spinTitle: String? {
        set { _spinTitle = newValue }
        get { return _spinTitle }
    }
    
    /// Is `spinButton` hidden
    @IBInspectable var isSpinHidden: Bool {
        set { spinButton?.isHidden = newValue }
        get { return spinButton?.isHidden ?? false }
    }
    
    /// Is `spinButton` enabled
    @IBInspectable var isSpinEnabled: Bool {
        set { spinButton?.isUserInteractionEnabled = newValue }
        get { return spinButton?.isUserInteractionEnabled ?? true }
    }
}

// -MARK: Deprecated API
public extension SwiftFortuneWheel {
    
    /// Starts indefinite rotation animation
    /// - Parameters:
    ///   - rotationTime: Rotation time is how many seconds needs to rotate all full rotation counts, default value is `5.000`
    ///   - fullRotationCountInRotationTime: How many rotation should be done for spefied rotation time, default value is `7000`
    @available(*, deprecated, message: "Use startContinuousRotationAnimation(with: speed) instead")
    func startAnimating(rotationTime: CFTimeInterval = 5.000, fullRotationCountInRotationTime: CGFloat = 7000) {
        self.stopAnimating()
        let speed = fullRotationCountInRotationTime / (360 * CGFloat(rotationTime))
        startContinuousRotationAnimation(with: speed)
    }
    
    /// Stops all animations
    @available(*, deprecated, renamed: "stopRotation")
    func stopAnimating() {
        self.stopRotation()
    }
    
    /// Starts indefinite rotation and stops rotation at the specified index
    /// - Parameters:
    ///   - indefiniteRotationTimeInSeconds: full rotation time in seconds before stops
    ///   - finishIndex: finished at index
    ///   - completion: completion
    @available(*, deprecated, message: "Use startRotationAnimation(finishIndex:continuousRotationTime:completion:) instead")
    func startAnimating(indefiniteRotationTimeInSeconds: Int, finishIndex: Int, _ completion: ((Bool) -> Void)?) {
        self.startRotationAnimation(finishIndex: finishIndex, continuousRotationTime: indefiniteRotationTimeInSeconds, completion)
    }
    
    /// Starts rotation animation and stops rotation at the specified index and rotation angle offset
    /// - Parameters:
    ///   - finishIndex: finished at index
    ///   - rotationOffset: Rotation offset
    ///   - fullRotationsUntilFinish: Full rotations until start deceleration
    ///   - animationDuration: Animation duration
    ///   - completion: completion
    @available(*, deprecated, renamed: "startRotationAnimation(finishIndex:rotationOffset:fullRotationsCount:animationDuration:completion:)")
    func startAnimating(finishIndex: Int, rotationOffset: CGFloat, fullRotationsUntilFinish: Int = 13, animationDuration: CFTimeInterval = 5.000, _ completion: ((Bool) -> Void)?) {
        self.startRotationAnimation(finishIndex: finishIndex, rotationOffset: rotationOffset, fullRotationsCount: fullRotationsUntilFinish, animationDuration: animationDuration, completion)
    }
    
    
    
    /// Starts rotation animation and stops rotation at the specified rotation offset angle
    /// - Parameters:
    ///   - rotationOffset: Rotation offset
    ///   - fullRotationsUntilFinish: Full rotations until start deceleration
    ///   - animationDuration: Animation duration
    ///   - completion: Completion handler
    @available(*, deprecated, renamed: "startRotationAnimation(rotationOffset:fullRotationsCount:animationDuration:completion:)")
    func startAnimating(rotationOffset: CGFloat, fullRotationsUntilFinish: Int = 13, animationDuration: CFTimeInterval = 5.000, _ completion: ((Bool) -> Void)?) {
        self.startRotationAnimation(rotationOffset: rotationOffset, fullRotationsCount: fullRotationsUntilFinish, animationDuration: animationDuration, completion)
    }
    
    /// Starts rotation animation and stops rotation at the specified index
    /// - Parameters:
    ///   - finishIndex: Finish at index
    ///   - fullRotationsUntilFinish: Full rotations until start deceleration
    ///   - animationDuration: Animation duration
    ///   - completion: Completion handler
    @available(*, deprecated, renamed: "startRotationAnimation(finishIndex:fullRotationsCount:animationDuration:completion:)")
    func startAnimating(finishIndex: Int, fullRotationsUntilFinish: Int = 13, animationDuration: CFTimeInterval = 5.000, _ completion: ((Bool) -> Void)?) {
        self.startRotationAnimation(finishIndex: finishIndex, fullRotationsCount: fullRotationsUntilFinish, animationDuration: animationDuration, completion)
    }
}
