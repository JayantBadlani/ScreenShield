// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.


import PackageDescription

let package = Package(
    name: "ScreenShield",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "ScreenShield",
            targets: ["ScreenShield"]),
    ],
    targets: [
        .target(
            name: "ScreenShield",
            path: "Source"),
    ]
)
