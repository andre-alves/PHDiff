// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "PHDiff",
    platforms: [
        .iOS(.v8),
        .tvOS(.v9),
        .watchOS(.v3),
        .macOS(.v10_11)
    ],
    products: [
        .library(
            name: "PHDiff",
            targets: [
                "PHDiff"
            ]
        ),
    ],
    targets: [
        .target(
            name: "PHDiff",
            path: "Sources"
        ),
        .testTarget(
            name: "PHDiffTests",
            dependencies: [
                "PHDiff"
            ],
            path: "Tests"
        ),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
