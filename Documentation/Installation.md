## Installation

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a dependency manager built into Xcode.

If you are using Xcode 11 or higher, go to **File / Swift Packages / Add Package Dependency...** and enter package repository URL **https://github.com/sh-khashimov/SwiftFortuneWheel.git**, then follow the instructions.

To remove the dependency, select the project and open **Swift Packages** (which is next to **Build Settings**). You can add and remove packages from this tab.

> Swift Package Manager can also be used [from the command line](https://swift.org/package-manager/).

### CocoaPods

`SwiftFortuneWheel ` is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod 'SwiftFortuneWheel'
```

### Submodule

If you don't use CocoaPods, you can still add `SwiftFortuneWheel` as a submodule, drag and drop `SwiftFortuneWheel.xcodeproj` into your project, and embed `SwiftFortuneWheel.framework` in your target.

- Drag `SwiftFortuneWheel.xcodeproj` to your project
- Select your app target
- Click the `+` button on the `Embedded binaries` section
- Add `SwiftFortuneWheel.framework`

### Manual

You can directly drag and drop the needed files into your project, but keep in mind that this way you won't be able to automatically get all the latest `SwiftFortuneWheel` features (e.g. new files including new operations).

The files are contained in the `Sources/SwiftFortuneWheel ` folder.