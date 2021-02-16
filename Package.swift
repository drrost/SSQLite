// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "SSQLite",
    products: [
        .library(
            name: "SSQLite",
            targets: ["SSQLite"]),
    ],
    dependencies: [
        .package(
            name: "ExtensionsFoundation",
            url: "git@github.com:drrost/swift-extensions-foundation.git",
            from: "0.0.1"),
        .package(
            name: "RDError",
            url: "git@github.com:drrost/swift-error.git",
            from: "1.0.0")
    ],
    targets: [
        .target(
            name: "SSQLite",
            dependencies: ["ExtensionsFoundation", "RDError"]),
        .testTarget(
            name: "SSQLiteTests",
            dependencies: ["SSQLite"],
            resources: [
                .process("ResourcesTest")
            ]
        )
    ]
)

