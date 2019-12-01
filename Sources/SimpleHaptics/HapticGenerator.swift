import Foundation
import CoreHaptics

public final class SimpleHapticGenerator: ObservableObject {

    private let hapticEngine: CHHapticEngine?

    private var needsToRestart = false

    /// Fires a transient haptic event with the given intensity and sharpness (0-1).
    public func fire(intensity: Float = 0.75, sharpness: Float = 0.75) throws {
        let event = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
            ],
            relativeTime: 0)
        let pattern = try CHHapticPattern(events: [event], parameters: [])
        let player = try hapticEngine?.makePlayer(with: pattern)
        if needsToRestart {
            try? start()
        }
        try player?.start(atTime: 0)
    }

    public init() {
        hapticEngine = try? CHHapticEngine()
        hapticEngine?.resetHandler = resetHandler
        hapticEngine?.stoppedHandler = restartHandler
        try? start()
    }

    /// Stops the internal CHHapticEngine. Should be called when your app enters the background.
    public func stop(completionHandler: CHHapticEngine.CompletionHandler? = nil) {
        hapticEngine?.stop(completionHandler: completionHandler)
    }

    /// Starts the internal CHHapticEngine. Should be called when your app enters the foreground.
    public func start() throws {
        try hapticEngine?.start()
        needsToRestart = false
    }

    private func resetHandler() {
        do {
            try start()
        } catch {
            needsToRestart = true
        }
    }

    private func restartHandler(_ reasonForStopping: CHHapticEngine.StoppedReason? = nil) {
        resetHandler()
    }

}
