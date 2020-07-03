//
//  SwiftFortuneWheel.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 5/28/20.
// 
//

import UIKit

@IBDesignable
/// Customizable Fortune spinning wheel control written in Swift.
public class SwiftFortuneWheel: UIControl {

    /// Called when spin button tapped
    public var onSpinButtonTap: (() -> Void)?

    /// Wheel view
    private var wheelView: WheelView?

    /// Pin image view
    private lazy var pinImageView = PinImageView()

    /// Spin button
    private lazy var spinButton = SpinButton()

    /// Animator
    lazy private var animator:SpinningWheelAnimator = SpinningWheelAnimator(withObjectToAnimate: self)

    /// Customizable configuration.
    /// Required in order to draw properly.
    public var configuration: SwiftFortuneWheelConfiguration? {
        didSet {
            updatePreferences()
        }
    }

    /// List of Slice objects.
    /// Used to draw content.
    open var slices: [Slice] = [] {
        didSet {
            self.wheelView?.slices = slices
        }
    }

    /// Pin image name from assets catalog
    private var _pinImageName: String? {
        didSet {
            pinImageView.image(name: _pinImageName)
        }
    }

    /// Spin button image name from assets catalog
    private var _spinButtonImageName: String? {
        didSet {
            spinButton.image(name: _spinButtonImageName)
        }
    }

    /// Spin button background image from assets catalog
    private var _spinButtonBackgroundImageName: String? {
        didSet {
            spinButton.backgroundImage(name: _spinButtonImageName)
        }
    }

    /// Initiates without IB.
    /// - Parameters:
    ///   - frame: Frame
    ///   - slices: List of Slices
    ///   - configuration: Customizable configuration
    public init(frame: CGRect, slices: [Slice], configuration: SwiftFortuneWheelConfiguration?) {
        self.configuration = configuration
        self.slices = slices
        self.wheelView = WheelView(frame: frame, slices: self.slices, preferences: self.configuration?.wheelPreferences)
        super.init(frame: frame)
        setupWheelView()
        setupPinImageView()
        setupSpinButton()
    }

    /// Adds pin image view to superview.
    /// Updates its layouts and image if needed.
    private func setupPinImageView() {
        self.addSubview(pinImageView)
        pinImageView.setupAutoLayout(with: configuration?.pinPreferences)
        pinImageView.image(name: _pinImageName)
    }

    /// Adds spin button  to superview.
    /// Updates its layouts and content if needed.
    private func setupSpinButton() {
        self.addSubview(spinButton)
        spinButton.setupAutoLayout(with: configuration?.spinButtonPreferences)
        spinButton.setTitle(spinTitle, for: .normal)
        spinButton.backgroundImage(name: _spinButtonImageName)
        spinButton.image(name: _spinButtonImageName)
        spinButton.configure(with: configuration?.spinButtonPreferences)
        spinButton.addTarget(self, action: #selector(spinAction), for: .touchUpInside)
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
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layer.needsDisplayOnBoundsChange = true
    }

    public required init?(coder aDecoder: NSCoder) {
        self.wheelView = WheelView(coder: aDecoder)
        super.init(coder: aDecoder)
        setupWheelView()
        setupPinImageView()
        setupSpinButton()
    }

    /// Updates subviews preferences
    private func updatePreferences() {
        self.wheelView?.preferences = configuration?.wheelPreferences
        pinImageView.setupAutoLayout(with: configuration?.pinPreferences)
        spinButton.setupAutoLayout(with: configuration?.spinButtonPreferences)
        spinButton.configure(with: configuration?.spinButtonPreferences)
    }

}

extension SwiftFortuneWheel: SliceCalculating {}

extension SwiftFortuneWheel: SpinningAnimatorProtocol {

    //// Animation conformance
    internal var layerToAnimate: SpinningAnimatable? {
        return self.wheelView?.wheelLayer
    }
    
    
    /// Rotates to the specified index
    /// - Parameters:
    ///   - index: Index
    ///   - animationDuration: Animation duration
    open func rotate(toIndex index: Int, animationDuration: CFTimeInterval = 0.00001) {
        let _index = index < self.slices.count ? index : self.slices.count - 1
        let rotation = 360.0 - computeRadian(from: _index)
        guard animator.currentRotationPosition != rotation else { return }
        self.stopAnimating()
        self.animator.addRotationAnimation(fullRotationsUntilFinish: 0,
                                           animationDuration: animationDuration,
                                           rotationOffset: rotation,
                                           completionBlock: nil)
    }
    
    
    /// Rotates to the specified index
    /// - Parameters:
    ///   - rotationOffset: Rotation offset
    ///   - animationDuration: Animation duration
    open func rotate(rotationOffset: CGFloat, animationDuration: CFTimeInterval = 0.00001) {
        guard animator.currentRotationPosition != rotationOffset else { return }
        self.stopAnimating()
        self.animator.addRotationAnimation(fullRotationsUntilFinish: 0,
                                           animationDuration: animationDuration,
                                           rotationOffset: rotationOffset,
                                           completionBlock: nil)
    }
    

    /// Start animating
    /// - Parameters:
    ///   - rotationOffset: Rotation offset
    ///   - fullRotationsUntilFinish: Full rotations until start deceleration
    ///   - animationDuration: Animation duration
    ///   - completion: Completion handler
    open func startAnimating(rotationOffset: CGFloat = 0.0, fullRotationsUntilFinish: Int = 13, animationDuration: CFTimeInterval = 5.000, _ completion:((Bool) -> Void)?) {
        
        self.stopAnimating()
        self.animator.addRotationAnimation(fullRotationsUntilFinish: fullRotationsUntilFinish,
                                           animationDuration: animationDuration,
                                           rotationOffset: rotationOffset,
                                           completionBlock: completion)
    }

    /// Start animating
    /// - Parameters:
    ///   - finishIndex: Finish at index
    ///   - fullRotationsUntilFinish: Full rotations until start deceleration
    ///   - animationDuration: Animation duration
    ///   - completion: Completion handler
    open func startAnimating(finishIndex:Int = 0, fullRotationsUntilFinish: Int = 13, animationDuration: CFTimeInterval = 5.000, _ completion:((Bool) -> Void)?) {
        
        let rotation = 360.0 - computeRadian(from: finishIndex)
        self.startAnimating(rotationOffset: rotation,
                            fullRotationsUntilFinish: fullRotationsUntilFinish,
                            animationDuration: animationDuration,
                            completion)
    }


    /// Start animating
    /// - Parameters:
    ///   - indefiniteRotationTimeInSeconds: full rotation time in seconds before stops
    ///   - finishIndex: finished at index
    ///   - completion: completion
    open func startAnimating(indefiniteRotationTimeInSeconds: Int, finishIndex: Int, _ completion:((Bool) -> Void)?) {
        
        self.startAnimating()
        let deadline = DispatchTime.now() + DispatchTimeInterval.seconds(indefiniteRotationTimeInSeconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.startAnimating(finishIndex: finishIndex) { (finished) in
                completion?(finished)
            }
        }
    }

    /// Start indefinite rotation animating
    open func startAnimating() {
        self.animator.addIndefiniteRotationAnimation()
    }

    /// Stop animating
    open func stopAnimating() {
        self.layerToAnimate?.removeAllAnimations()
    }

    /// Start animating
    /// - Parameters:
    ///   - finishIndex: finished at index
    ///   - rotationOffset: Rotation offset
    ///   - fullRotationsUntilFinish: Full rotations until start deceleration
    ///   - animationDuration: Animation duration
    ///   - completion: completion
    open func startAnimating(finishIndex:Int = 0, rotationOffset:CGFloat, fullRotationsUntilFinish: Int = 13, animationDuration: CFTimeInterval = 5.000, _ completion:((Bool) -> Void)?) {
        
        let rotation = 360.0 - computeRadian(from: finishIndex) + rotationOffset
        self.startAnimating(rotationOffset: rotation,
                            fullRotationsUntilFinish: fullRotationsUntilFinish,
                            animationDuration: animationDuration,
                            completion)
    }
}


public extension SwiftFortuneWheel {

    /// Pin image name from assets catalog
    @IBInspectable var pinImage: String? {
        set { _pinImageName = newValue }
        get { return _pinImageName }
    }

    /// Pin image is hidden
    @IBInspectable var isPinHidden: Bool {
        set { pinImageView.isHidden = newValue }
        get { return pinImageView.isHidden }
    }

    /// Spin button image name from assets catalog
    @IBInspectable var spinImage: String? {
        set { _spinButtonImageName = newValue }
        get { return _spinButtonImageName }
    }

    /// Spin button background image from assets catalog
    @IBInspectable var spinBackgroundImage: String? {
        set { _spinButtonBackgroundImageName = newValue }
        get { return _spinButtonBackgroundImageName }
    }

    /// Spin button title text
    @IBInspectable var spinTitle: String? {
        set { spinButton.setTitle(newValue, for: .normal) }
        get { return spinButton.titleLabel?.text }
    }

    /// Spin button is hidden
    @IBInspectable var isSpinHidden: Bool {
        set { spinButton.isHidden = newValue }
        get { return spinButton.isHidden }
    }

    /// Spin button is enabled
    @IBInspectable var isSpinEnabled: Bool {
        set { spinButton.isEnabled = newValue }
        get { return spinButton.isEnabled }
    }
}
