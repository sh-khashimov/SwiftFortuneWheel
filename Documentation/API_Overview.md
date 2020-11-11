## API Overview

- [Rotation API](#Rotation-API)
- [pinImageView and spinButton API](#pinImageView-and-spinButton-API)

---

### Rotation API

Rotation API helps you to rotate to a slice index or to a specified angle, with or without animation.

</br>

- Rotates to the specified index.
If you need to rotate with animation, change the `animationDuration`.
``` Swift
func rotate(toIndex index: Int, animationDuration: CFTimeInterval = 0.00001)
```
- Rotates to the specified angle offset.
If you need to rotate with animation, change the `animationDuration`.
``` Swift
func rotate(rotationOffset: CGFloat, animationDuration: CFTimeInterval = 0.00001)
```

</br>


- Starts continuos rotation animation
``` Swift
func startContinuousRotationAnimation()
```
- Stops all animations
``` Swift
func stopRotation()
```


</br>

- Starts rotation animation and stops rotation at the specified index and rotation angle offset. 
``` Swift
func startRotationAnimation(finishIndex: Int, rotationOffset: CGFloat, _ completion: ((Bool) -> Void)?)
```
- Starts rotation animation and stops rotation at the specified index.
``` Swift
func startRotationAnimation(finishIndex: Int, _ completion: ((Bool) -> Void)?)
```
- Starts rotation animation and stops rotation at the specified rotation offset angle.
``` Swift
func startRotationAnimation(rotationOffset: CGFloat, _ completion: ((Bool) -> Void)?)
```
- Starts continuos rotation and stops rotation at the specified index.
``` Swift
func startRotationAnimation(finishIndex: Int, continuousRotationTime: Int, _ completion: ((Bool) -> Void)?)
```

---

### pinImageView and spinButton API

There some variables that can be set via Interface Builder or through code. However, if you need deeper customize `pinImageView` or `spinButton`, you need also use `pinPreferences` or `spinButtonPreferences` in the `configuration` parameter.

</br>


- Pin image name from assets catalog, sets image to the `pinImageView`.

``` Swift
@IBInspectable var pinImage: String?
```

- is `pinImageView` hidden.

``` Swift
@IBInspectable var isPinHidden: Bool
```

- Spin button image name from assets catalog, sets image to the `spinButton`.

``` Swift
@IBInspectable var spinImage: String?
```

- Spin button background image from assets catalog, sets background image to the `spinButton`.

``` Swift
@IBInspectable var spinBackgroundImage: String?
```

- Spin button title text, sets title text to the `spinButton`.

``` Swift
@IBInspectable var spinTitle: String?
```

- Is `spinButton` hidden.

``` Swift
@IBInspectable var isSpinHidden: Bool
```


- Is `spinButton` enabled.

``` Swift
@IBInspectable var isSpinEnabled: Bool
```