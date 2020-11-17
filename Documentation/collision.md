## `pinImageView` Collision effect and Collision Callbacks
**`SwiftFortuneWheel`** can simulate the collision effect for `pinImageView` when the edge or the center of a slice moves during the rotation.

### `pinImageView` Collision effect example

``` Swift
@IBOutlet weak var fortuneWheel: SwiftFortuneWheel!
// after SwiftFortuneWheel init and configuration…

// Creates the CollisionEffect for pinImageView
fortuneWheel.pinImageViewCollisionEffect = CollisionEffect(force: 8, angle: 20)
            
// Turn on the edge collision detection
// One of the collision detection should be on in order to simulate the collision effect
fortuneWheel.edgeCollisionDetectionOn = true

```

> **For more information, see [example projects](../Examples)** -> `VariousWheelSimpleViewController`

> _`pinImageView` Collision effect is not available on **macOS**_

- - -

You can use the collision callback and implement your own effect:

### Example of use callback for Edge Collision

``` Swift 
@IBOutlet weak var fortuneWheel: SwiftFortuneWheel!
// after SwiftFortuneWheel init and configuration…

// edge collision callback with progress, if rotation is continuous, progress is equal to nil
fortuneWheel.onEdgeCollision = { progress in
       print("edge collision progress: \(String(describing: progress))")
}

// turn on the edge collision detection
fortuneWheel.edgeCollisionDetectionOn = true

```


### Example of use callback for Center Collision

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

> **For more information, see [example projects](../Examples)**