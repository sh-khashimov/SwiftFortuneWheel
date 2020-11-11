# Getting Started
- [**How to use**](#how—to-use)
- [**Visual diagram**](#visual—diagram)
- [**Necessarily note**](#necessarily—note)

## How to use

- Import **SwiftFortuneWheel** to your ViewController class:

``` Swift
import SwiftFortuneWheel
```

- Add `UIView` to Storyboard's ViewController. Change class and module to `SwiftFortuneWheel` and @IBOutlet to your ViewController:

<img src="../Images/storyboard.png" width="500"/>

> _Make sure that your `SwiftFortuneWheel` view has 1:1 aspect ratio._

- Change basic preferences in you Interface Builder:


<img src="../Images/ibpreferences.png" width="300"/>

> **For more information, see the [API Overview](API_Overview.md)**.

``` Swift
/// Fortune Wheel
@IBOutlet weak var fortuneWheel: SwiftFortuneWheel!
```

- Create slice content list:

``` Swift
var slices: [Slice] = []
let imagePreferences = ImagePreferences(preferredSize: CGSize(width: 40, height: 40), verticalOffset: 40)
let imageSliceContent = Slice.ContentType.assetImage(name: "crown", preferenes: imagePreferences)
let slice = Slice(contents: [imageSliceContent])
slices.append(slice)
```

> **For more information, see the [About Slice and Slice’s contents](About_Slice_and_Slice_contents.md)**.

- Create a `SwiftFortuneWheel` configuration:


``` Swift
let sliceColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: .black, oddColor: .cyan)

let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceColorType, strokeWidth: 1, strokeColor: .black)

let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: 10, strokeColor: .black)

let wheelPreferences = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences, slicePreferences: slicePreferences, startPosition: .bottom)

let configuration = SFWConfiguration(wheelPreferences: wheelPreferences)
```

> **For detail information, how to create a configuration object, see the [Configuration In-Depth](Configuration_indepth.md)**.

- Pass slices and configuration to the `SwiftFortuneWheel`:

``` Swift
fortuneWheel.configuration = configuration
fortuneWheel.slices = slices
```

- To start spin animation:

``` Swift
fortuneWheel.startRotationAnimation(finishIndex: 0, continuousRotationTime: 1) { (finished) in
            print(finished)
        }
```

> **For more information, see the [API Overview](API_Overview.md)**.

</br>

## Visual diagram

<img src="../Images/diagram.jpg" width="420"/>

1. **`WheelView`** (configures with `SFWConfiguration.WheelPrefereces`)

2. **`SFWConfiguration.AnchorImage`**, optional

3. **`SpinButton`** (configures with `SFWConfiguration.SpinButtonPreferences`)

4. **`PinImageView`** (configures with `SFWConfiguration.PinImageViewPreferences`).

5. **`Slice`** (configures with `SlicePreferences`)

6. List of **`Slice.ContentType`**

7. **`Slice.ContentType.image`** or **`Slice.ContentType.assetImage`** (configures with `ImagePreferences`)

8. **`Slice.ContentType.text`** (configures with `TextPreferences`)

</br>

## Necessarily note

> _Please note that in order to properly draw objects, `SwiftFortuneWheel` is rellies on `SFWConfiguration`. It’s up to you how to configure but without configuration, `SwiftFortuneWheel` won’t work properly._

> **For detail information, how to create a configuration object, see the [Configuration In-Depth](Configuration_indepth.md)**.





