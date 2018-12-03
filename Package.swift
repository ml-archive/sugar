// swift-tools-version:4.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Sugar",
    products: [
        .library(
            name: "Sugar",
            targets: ["Sugar"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/auth.git", from: "2.0.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.1"),
        .package(url: "https://github.com/vapor/jwt.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/redis.git", from: "3.0.0"),
    ],
    targets: [
        .target(
            name: "Sugar",
            dependencies: ["Authentication", "Fluent", "Vapor", "Leaf", "JWT", "Redis"]
        ),
        .testTarget(
            name: "SugarTests",
            dependencies: ["Sugar"]
        ),
    ]
)
