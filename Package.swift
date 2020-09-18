// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SSQLite",
    products: [
        .library(
            name: "SSQLite",
            targets: ["SSQLite"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SSQLite",
            dependencies: []),
        .testTarget(
            name: "SSQLiteTests",
            dependencies: ["SSQLite"]),
    ]
)
