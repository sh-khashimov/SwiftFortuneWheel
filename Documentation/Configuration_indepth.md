## Configuration In-Depth

To draw a **`SwiftFortuneWheel`** control, you have to create an `SFWConfiguration` object and set it to `SwiftFortuneWheel`’s *`configuration`* variable. 

**`SFWConfiguration`** initializes with requered `WheelPreferences` object and with optional two `PinImageViewPreferences` and `SpinButtonPreferences` objects. 

**`WheelPreferences`** contains itself all necessary preferences to properly draw the wheel view, such as `CirclePreferences`, `SlicePreferences`, and other parameters.

If you initialize **`SFWConfiguration`** without `PinImageViewPreferences` or `SpinButtonPreferences`, `pinImageView` or `spinButton` won’t be drawn respectively. 

- - -

### Example



``` Swift 
let sliceColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: .black, oddColor: .cyan)

let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceColorType, strokeWidth: 1, strokeColor: .black)

let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: 10, strokeColor: .black)

let wheelPreferences = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences, slicePreferences: slicePreferences, startPosition: .bottom)

let configuration = SFWConfiguration(wheelPreferences: wheelPreferences)

swiftFortuneWheel.configuration = configuration
````

As you can see from the example, to draw a **`SwiftFortuneWheel`** you need to create at least 5 preferences.

To make it easier, you can create an extension for **`SwiftFortuneWheel`**:

``` Swift 
extension SFWConfiguration {
	static var defaultConfiguration: SFWConfiguration {
		let sliceColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: .black, oddColor: .cyan)

		let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceColorType, strokeWidth: 1, strokeColor: .black)

		let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: 10, strokeColor: .black)

		let wheelPreferences = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences, slicePreferences: slicePreferences, startPosition: .bottom)

		let configuration = SFWConfiguration(wheelPreferences: wheelPreferences)

		return configuration
	}
}
```

``` Swift
class myViewController: UIViewController {
	 override func viewDidLoad() {
        super.viewDidLoad()
				swiftFortuneWheel.configuration = .defaultConfiguration
    }
}
```


> **For more information, see [example projects](../Examples)**