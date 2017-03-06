import PackageDescription

let package = Package(
    name: "Sugar",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1),
        .Package(url: "https://github.com/vapor/mysql-driver.git", majorVersion: 1),
          .Package(url: "https://github.com/bygri/vapor-forms.git", majorVersion:0)
    ]
)
