## Migration

### from 1.1.x to 1.2.x

- Fix the warning messages

Animation API was changed:

- `startAnimating` was renamed to `startRotationAnimation`;
- `stopAnimating` was renamed to `stopRotation`;
- `startAnimating(rotationTime: CFTimeInterval = 5.000, fullRotationCountInRotationTime: CGFloat = 7000)` was deprecated, use `startContinuousRotationAnimation(with: speed)` instead;
- `startAnimating(indefiniteRotationTimeInSeconds: Int, finishIndex: Int, _ completion: ((Bool) -> Void)?)` was deprecated, use `startRotationAnimation(finishIndex:continuousRotationTime:completion:)` instead;