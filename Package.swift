// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "DiceBag",
  products: [
    .library(
      name: "DiceBag",
      targets: [
        "DiceBag"
      ]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "0.2.0"),
  ],
  targets: [
    .target(
      name: "DiceBag",
      dependencies: [
      ]
    ),
    .target(
      name: "roll",
      dependencies: [
        "DiceBag",
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ]
    ),
    .testTarget(
      name: "DiceBagTests",
      dependencies: [
        "DiceBag",
      ]
    ),
  ]
)
