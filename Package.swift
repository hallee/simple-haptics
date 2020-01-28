// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "SimpleHaptics",
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
