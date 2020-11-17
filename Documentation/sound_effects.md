## Sound Effects and Impact Feedback

**`SwiftFortuneWheel`** can play sounds when the edge or the center of a slice moves during the rotation. Optionally, it’s possible to turn on the haptic feedback while playing sound.

### Edge Collision Sound Effect Example

``` Swift 
@IBOutlet weak var fortuneWheel: SwiftFortuneWheel!
// after SwiftFortuneWheel init and configuration…

// add Click.mp3 to your project, create AudioFile, and set to edgeCollisionSound
fortuneWheel.edgeCollisionSound = AudioFile(filename: "Click", extensionName: "mp3")

// optionally, turn on the haptic feedback for each impact
fortuneWheel.impactFeedbackOn = true

// turn on the edge collision detection
fortuneWheel.edgeCollisionDetectionOn = true

```

### Center Collision Sound Effect Example

``` Swift 
@IBOutlet weak var fortuneWheel: SwiftFortuneWheel!
// after SwiftFortuneWheel init and configuration…

// add Click.mp3 to your project, create AudioFile, and set to centerCollisionSound
fortuneWheel.centerCollisionSound = AudioFile(filename: "Click", extensionName: "mp3")

// optionally, turn on the haptic feedback for each impact
fortuneWheel.impactFeedbackOn = true

// turn on the center collision detection
fortuneWheel.centerCollisionDetectionOn = true

```

> _**`impactFeedbackOn`** is only available on iOS 10 and above, not available on other platforms_

> **For more information, see [example projects](../Examples)**