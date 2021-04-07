# DesignDetective

### Preview

<img src="../main/Sources/DesignDetective/Demo/demo.gif" height="280"/>

### Usage

You may trigger anywhere, but I personally prefer using it via Shake Gesture

```swift
import DesignDetective

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        #if DEBUG
        if motion == .motionShake {
            if DesignDetective.shared.isActive {
                DesignDetective.shared.deActivate()
            } else {
                try? DesignDetective.shared.activate()
            }
        }
        #endif
    }
}
```

Our Detective grabs the most top view controller's view's snapshot (image), and presents a screen above it.

Accepts you to load image (via a URL), after you paste a url to your clipboard, you should be ready to go.

Or alternatively you can select an image from your photo album. (You can drag drop an image to the simulator)

To activate the detective, shake simulator/device ( for simulator => menu `Device > Shake`  or via shortcut  `Ctrl + CMD + Z` )

#### Reset Selected Image

* Double tap the selected Image
