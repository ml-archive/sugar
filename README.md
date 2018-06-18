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
