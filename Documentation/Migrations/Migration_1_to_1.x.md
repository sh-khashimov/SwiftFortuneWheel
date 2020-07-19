## Migration

### from 1.0.x to 1.1.x

When you updating from 1.0.x to version 1.1.x, you have to consider that you need to fix errors that caused due to changes in the initialization process in the most of the preferences:

- **`TextPreferences`** could be now initialize only with `textColorType`, `font` and `verticalOffset`, other parameters should be changed after initialization;
- **`ImagePreferences`** could be now initialize only with `preferedSize` and `verticalOffset`, other parameters should be changed after initialization;
- **`WheelPreferences`** could be now initialize only with `circlePreferences`, `slicePreferences` and `startPosition`, other parameters should be changed after initialization;
- **`SpinButtonPreferences`** could be now initialize only with `size`, `horizontalOffset` and `verticalOffset`, other parameters should be changed after initialization;
- **`PinImageViewPreferences`** could be now initialize only with `size`, `position`, `horizontalOffset` and `verticalOffset`, other parameters should be changed after initialization;
- **`AnchorImage`** could be now initialize only with `size`, `imageName`, and `verticalOffset`, other parameters should be changed after initialization;