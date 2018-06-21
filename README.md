# Sugar 🍬
[![Swift Version](https://img.shields.io/badge/Swift-4.1-brightgreen.svg)](http://swift.org)
[![Vapor Version](https://img.shields.io/badge/Vapor-3-30B6FC.svg)](http://vapor.codes)
[![Circle CI](https://circleci.com/gh/nodes-vapor/sugar/tree/master.svg?style=shield)](https://circleci.com/gh/nodes-vapor/sugar)
[![codebeat badge](https://codebeat.co/badges/54770476-a759-47f8-9372-1009267a56e0)](https://codebeat.co/projects/github-com-nodes-vapor-sugar-master)
[![codecov](https://codecov.io/gh/nodes-vapor/sugar/branch/master/graph/badge.svg)](https://codecov.io/gh/nodes-vapor/sugar)
[![Readme Score](http://readme-score-api.herokuapp.com/score.svg?url=https://github.com/nodes-vapor/sugar)](http://clayallsopp.github.io/readme-score?url=https://github.com/nodes-vapor/sugar)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/nodes-vapor/sugar/master/LICENSE)


## 📦 Installation

Update your `Package.swift` file.

```swift
.package(url: "https://github.com/nodes-vapor/sugar.git", from: "3.0.0-beta")
```


## Getting started 🚀

Make sure that you've imported Sugar everywhere when needed:

```swift
import Sugar
```


## Helpers

This package contains a lot of misc. functionality that might not fit into it's own package or that would best to get PR'ed into Vapor. Some examples of what this package contains:

### Mutable Leaf tag config

To allow third party packages to register their own Leaf tags, Sugar comes with a `MutableLeafTagConfig`.

#### How to use it in a package

To have your package register the tags to the shared config, you can do the following:

```swift
public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
    let tags: MutableLeafTagConfig = try container.make()
    tags.use(MyTag(), as: "mytag")

    return .done(on: container)
}
```

#### How to use it in a project

If you're using a package that uses the shared `MutableLeafTagConfig`, these tags will become available in your project automatically. If you have additional tags you want to add, these has to be registered in `boot.swift` instead of `configure.swift` to allow the different providers to have registered their tags to the config first. Here's how you could do it:

```swift
public func boot(_ app: Application) throws {
    // Register Leaf tags using the shared config.
    // This allows third party packages to register their own tags.
    let tags = try app.make(MutableLeafTagConfig.self)
    tags.use(MyAdditionalTag())
}
```

> You don't have to register `tags` when adding this in `boot.swift`.

In the case where multiple packages is registering a tag using the same name, the tags can be added manually by defining your own name for the tags.

### Environment variables

Access environment variables by writing

```swift
env("my-key", "my-fallback-value")
```

### Seeder commands

If you want to make your model seedable, you can conform it to `Seedable` and use `SeederCommand` to wrap your seedable model. This basically means that you can focus on how your model gets initialized when running your command, and save a little code on actually performing the database work.

> Seeding multiple instances of your model will be added - feel free to PR.

### Authentication

This package contains a lot of convenience related to JWT, usernames and passwords which is used in [JWTKeychain](https://github.com/nodes-vapor/jwt-keychain) and [Admin Panel](https://github.com/nodes-vapor/admin-panel).


## 🏆 Credits

This package is developed and maintained by the Vapor team at [Nodes](https://www.nodesagency.com).
The package owner for this project is [Siemen](https://github.com/siemensikkema).


## 📄 License

This package is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)
