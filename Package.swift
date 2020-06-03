// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "PHDiff",
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
    ]
)
