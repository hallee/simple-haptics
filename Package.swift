// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "SimpleHaptics",
    platforms: [
        .iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
    	.library(name: "SimpleHaptics", targets: ["SimpleHaptics"])
    ],
    targets: [
        .target(name: "SimpleHaptics"),
        .testTarget(
            name: "SimpleHapticsTests",
            dependencies: ["SimpleHaptics"],
            path: "Tests/SimpleHaptics"
        )
    ]
)
