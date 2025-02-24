// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppFoundation",
    defaultLocalization: "en",
    platforms: [.iOS(.v16)],
    targets: [
        .target(name: "AppFoundation", dependencies: ["AppData"]),
        .target(name: "AppUIComponent"),
        .target(name: "AppData"),
        .testTarget(name: "AppDataTests", dependencies: ["AppData"]),
        .target(name: "AppEntity"),
        .testTarget(name: "AppEntityTests", dependencies: ["AppEntity"]),
    ]
)

package.products = package.targets
    .filter { !$0.isTest }
    .map(\.name)
    .map { Product.library(name: $0, targets: [$0]) }
