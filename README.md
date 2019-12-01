# Simple Haptics

Simple Haptics is a convenience wrapper for [`Core Haptics`](https://developer.apple.com/documentation/corehaptics) to make it easier to fire transient haptic taps, similar to `UIFeedbackGenerator`.

## Usage

```swift
import SimpleHaptics

let haptics = SimpleHapticGenerator()

try? haptics.fire(intensity: 0.5, sharpness: 1)
```

### Integration with SwiftUI

Simple Haptics works well when integrated with `@Environment`. You can create a single `SimpleHapticGenerator` and pass it as an environment object to your root SwiftUI view, then use it in any child views that need haptic feedback. This prevents needing to initialize lots of `CHHapticEngine`s unecessarily, and allows you to stop and start the haptic engine on app lifecycle events. For example, in your `SceneDelegate`:

```swift
import SimpleHaptics
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    let haptics = SimpleHapticGenerator()

    ...

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let contentView = ContentView()
            .environmentObject(haptics) // Pass your haptic generator into your root View.

    ...

    // Be sure to stop the haptic generator when entering the background.
    func sceneDidEnterBackground(_ scene: UIScene) {
        haptics.stop()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        try? haptics.start()
    }

}
```

And then child views can use it simply by creating an `@EnvironmentObject` variable of the correct type:

```swift
import SimpleHaptics
import SwiftUI

struct MyView: View {

    @EnvironmentObject private var haptics: SimpleHapticGenerator

    ...

}
```



## Installation

#### SwiftPM

```swift
dependencies: [
    .package(url: "https://github.com/hallee/simple-haptics", from: "0.0.2")
],
targets: [
    .target(name: "YourTarget", dependencies: ["SimpleHaptics"])
]
```
