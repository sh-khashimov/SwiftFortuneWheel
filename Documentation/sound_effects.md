## Sound Effects and Impact Feedback

**`SwiftFortuneWheel`** can play sounds when the edge or the center of a slice moves during the rotation. Optionally, it’s possible to turn on the haptic feedback while playing sound. Or use the impact callback and implement your own effect.


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

### Example to use callback for Edge Collision

``` Swift 
@IBOutlet weak var fortuneWheel: SwiftFortuneWheel!
// after SwiftFortuneWheel init and configuration…

// edge collision callback with progress, if rotation is continuous, progress is equal to nil
fortuneWheel.onEdgeCollision = { progress in
       print("edge collision progress: \(String(describing: progress))")
}

// turn on the center collision detection
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

### Example to use callback for Center Collision

``` Swift 
@IBOutlet weak var fortuneWheel: SwiftFortuneWheel!
// after SwiftFortuneWheel init and configuration…

// center collision callback with progress, if rotation is continuous, progress is equal to nil
fortuneWheel.onCenterCollision = { progress in
       print("center collision progress: \(String(describing: progress))")
}

// turn on the center collision detection
fortuneWheel.centerCollisionDetectionOn = true

```

> _**`impactFeedbackOn`** is only available on iOS 10 and above, not available on other platforms_

> **For more information, see [example projects](../Examples)**