## CHANGELOG

### 1.4.0
- [Issue #15](https://github.com/sh-khashimov/SwiftFortuneWheel/issues/15)  removed @IBDesignable
- [Issue #16](https://github.com/sh-khashimov/SwiftFortuneWheel/issues/16)  added gradient color for a slice


### 1.3.3
- Fixed issue when tap to slice can return incorrect slice index;
- Tap gesture recognizer ported to macOS;

### 1.3.2
- [Issue #10](https://github.com/sh-khashimov/SwiftFortuneWheel/issues/10) added tap gesture API to detect selected slice index via tap. For more information see [**API Overview**](API_Overview.md);
- Refactoring;

### 1.3.1
- [Issue #11](https://github.com/sh-khashimov/SwiftFortuneWheel/issues/11): startRotationAnimation completion issue fix;

### 1.3.0
- [Issue #6](https://github.com/sh-khashimov/SwiftFortuneWheel/issues/6): `pinImageView` collision effect animation added;

### 1.2.0

- Added sound effect and haptic feedback during the rotation;
- [Issue #6](https://github.com/sh-khashimov/SwiftFortuneWheel/issues/6): animation callback added;
- Animation API refined;
- iOS Example project updated; 

### 1.1.3

- `characterWrap` type added to the `TextPreferences.LineBreakMode`;
- `maxWidth` added to the `TextPreferences`. With `maxWdith` possible to set maximum width that will be available for text;
- Fixed text margins;
- Fixed when `numberOfLines = 0` may not work properly;

### 1.1.2

- SPM macOS support added;

### 1.1.1
- [Issue #8](https://github.com/sh-khashimov/SwiftFortuneWheel/issues/8): Added background image for Slice object;

### 1.1.0

- Added support for **macOS 10.11** and above;
- Added support for **tvOS 9.0** and above;
- **`TextPreferences`** initialize process changed;
- **`ImagePreferences`** initialize process changed;
- **`WheelPreferences`** initialize process changed;
- **`SpinButtonPreferences`** initialize process changed;
- **`PinImageViewPreferences`** initialize process changed;
- **`AnchorImage`** initialize process changed;
- Fixed image `flipUpsideDown` from not working;
- See migration process here: [**from 1.0.x to 1.x.x**](Migrations/Migration_1_to_1.x.md);

### 1.0.3

- When you using `startAnimating` method to start indefinite rotation animation, it’s possible now change optional `rotationTime` and `fullRotationCountInRotationTime` parameters to change the rotation speed;

### 1.0.2

- Fixed memory leak when re-drawing the wheel;

### 1.0.1

- Fixed layout warnings;
- Fixed incorrect spinButton background image setting;
- Fixed incorrect spinButton isEnabled setting;
- Fixed incorrect content image position;
- Fixed incorrect content line position;
- Fixed incorrect slice border width;
- Fixed incorrect content position after setting circle border height;
- Fixed horizontal position in the vertical text;
- Other small improvements are made;

### 1.0.0

- Small improvements and bug fixes;
- Updated example project with rotation and animation API example;
- Pull request [#4](https://github.com/sh-khashimov/SwiftFortuneWheel/pull/4) merged;
- See migration information here: [**from 0.x.x to 1.0.0**](Migrations/Migration_0_to_1.md);

### 0.9.0
- Added rotation API: `rotate(toIndex index: Int)`, `rotate(rotationOffset: CGFloat)`;
- Added parameters *full rotations until start deceleration* and *animation duration* to animation API;
- `startAnimating(fullRotationTimeInSeconds: Int, finishIndex: Int)` changed to `startAnimating(indefiniteRotationTimeInSeconds: Int, finishIndex: Int)`
- Internal code refactoring;

### 0.8.1
- Issue #2 fix;

### 0.8.0
- Text now can be separated into `lines`;
- Added `line break mode` to the `TextPreferences`;
- Added `spacing` between lines to the `TextPreferences`;
- Added `alignment` to the `TextPreferences`;

### 0.7.0
- Added text orientation to `TextPreferences`;
- `preferedFontSize` removed from `TextPreferences`;
- `flipUpsideDown` fixed;


### v0.6.2
- Fixed bug during init process;
- In `TextPreferences`, `flipUpsideDown` now default value is `true`;
- Playground added to `SwiftFortuneWheel` project;


### v0.6.1

- `startAnimating(fullRotationTimeInSeconds: Int, finishIndex: Int, _ completion:((Bool) -> Void)?)` - completion fix

### v0.6.0
- Added `line` to `Slice.ContentType` and `LinePreferences`. Now supports a curved line inside a slice;
- Optional `backgroundColor` added to `Slice`. You can now override a background color for specified `Slice`, during `Slice` initialization;
- Optional `centerImageAnchor` added to `WheelPreferences`. You can now add a secondary anchor image for each slice that will be located at the center of wheel’s border;
- Examples updated;

### v0.5.0

First public release
