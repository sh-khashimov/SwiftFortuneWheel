## CHANGELOG

### 1.0.0

- Small improvements and bug fixes;
- Updated example project with rotation and animation API example;
- Pull request [#4](https://github.com/sh-khashimov/SwiftFortuneWheel/pull/4) merged;
- See migration information here: [**from 0.x.x to 1.0.0**](/Migrations/Migration_0_to_1.md);

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