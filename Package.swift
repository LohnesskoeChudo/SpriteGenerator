// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SpriteGenerator",
    products: [
        .library(
            name: "SpriteGenerator",
            targets: ["SpriteGenerator"]),
    ],
    
    targets: [
        .target(
            name: "SpriteGenerator",
            dependencies: [],
            path: "Sources/"),
    ]
)
