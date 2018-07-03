import PackageDescription

let package = Package(
    name: "Sugar",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2),
        .Package(url: "https://github.com/vapor/fluent-provider.git", majorVersion: 1),
        .Package(url: "https://github.com/vapor/validation.git", majorVersion: 1),
        .Package(url: "https://github.com/vapor/auth-provider.git", majorVersion: 1),
    ]
)
