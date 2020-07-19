## Port to Other Platforms

### macOS

**SwiftFortuneWheel** is ported to **macOS** at `version 1.1.0` and should work natively. However, you should note that the `SwiftFortuneWheel` view could be clipped with `NSView`, in order to fix that, you can add the inner spacing with auto-layout in your constrains and you need also specify `alignmentRectInsets` in the configuration.

> **See [SwiftFortuneWheelDemo-macOS example](../Examples)**

### tvOS

**SwiftFortuneWheel** is compatible with **tvOS 9** and above starting from `version 1.1.0` and should work the same as on iOS.

> **See [SwiftFortuneWheelDemo-tvOS example](../Examples)**

### watchOS

I'm not considering the port to **watchOS**. At least I’m not seeing any reason to do so, due to limitations that **watchOS** has. However, port to **swiftUI** with support with **watchOS** thinkable.
