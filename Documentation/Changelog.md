## CHANGELOG

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