## CHANGELOG

### 0.9.0
- Added rotation API: `rotate(toIndex index: Int)`, `rotate(rotationOffset: CGFloat)`;
- Added parameters *full rotations until start deceleration* and *animation duration* to animation API;
- `startAnimating(fullRotationTimeInSeconds: Int, finishIndex: Int)` changed to `startAnimating(indefiniteRotationTimeInSeconds: Int, finishIndex: Int)`
- Internal code refactoring;

### 0.8.1
- Issue #2 fix;

### 0.8.0
- Text now can be separated into `lines`;
- Added `line break mode` to the text preferences;
- Added `spacing` between lines to the text preferences;
- Added `alignment` to the text preferences;

### 0.7.0
- added text orientation to `TextPreferences`;
- `preferedFontSize` removed from `TextPreferences`;
- `flipUpsideDown` fixed;


### v0.6.2
- fixed bug during init process;
- in `TextPreferences`, `flipUpsideDown` now default value is `true`;
- Playground added to `SwiftFortuneWheel` project;


### v0.6.1

- `startAnimating(fullRotationTimeInSeconds: Int, finishIndex: Int, _ completion:((Bool) -> Void)?)` - completion fix

### v0.6.0
- added `line` to `Slice.ContentType` and `LinePreferences`. Now supports a curved line inside a slice;
- Optional `backgroundColor` added to `Slice`. You can now override a background color for specified `Slice`, during `Slice` initialization;
- Optional `centerImageAnchor` added to `WheelPreferences`. You can now add a secondary anchor image for each slice that will be located at the center of wheel’s border;
- Examples updated;

### v0.5.0

First public release