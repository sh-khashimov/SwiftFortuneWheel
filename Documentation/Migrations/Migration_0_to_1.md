## Migration

### from 0.x.x to 1.0.0

When you updating from 0.x.x to version 1.0.0, you have to consider next changes that were made:

- The biggest changes were that long named `SwiftFortuneWheelConfiguration` was renamed to shorter `SFWConfiguration`;
- `pinPreferences` and `spinButtonPreferences` inside `SFWConfiguration` now are optional;
- When you initializing `WheelPreferences` now you have to specify `startPosition`;
- `image(String, ImagePreferences)` renamed to `assetImage(String, ImagePreferences)` case at `Slice.ContentType`  
- Added `image(UIImage, ImagePreferences)` case to `Slice.ContentType` 

### Other changes from 0.5.0 to 0.9.0


#### from 0.6.x to 0.7.0

- `preferedFontSize` removed from `TextPreferences`;

#### from 0.6.0 to 0.6.2
- In `TextPreferences`, `flipUpsideDown` now default value is `true`;
