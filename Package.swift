// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "sad-sdk-ios",
    platforms: [
        .iOS(.v8)
    ],
    products: [
        .library(
            name: "SensorsAdvertising",
            targets: ["SensorsAdvertisingWrapper"]),
    ],
    dependencies: [
        .package(
            name: "sa-sdk-ios",
            url: "https://github.com/asura1234/sa-sdk-ios.git",
            .revisionItem("5cc1b979f11cf947c1a78b47e1d02db291c1e961")
        ),
    ],
    targets: [
        .binaryTarget(
            name: "SensorsAdvertising",
            path: "SensorsAdvertising/SensorsAdvertising.xcframework"),
        /// binary target cannot have dependencies, therefore a wrapper target is needed
        .target(
            name: "SensorsAdvertisingWrapper",
            dependencies: [
                .target(name: "SensorsAdvertising", condition: .when(platforms: [.iOS])),
                .product(name: "SensorsAnalyticsCore", package: "sa-sdk-ios"),
                .product(name: "SensorsAnalyticsStore", package: "sa-sdk-ios")
            ],
            /// the directory cannot be empty, there needs to be at least a single `.h` and `.m` file
            path: "SensorsAdvertisingWrapper"
        )
    ]
)
