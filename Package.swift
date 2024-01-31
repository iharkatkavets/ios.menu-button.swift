// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MenuButton",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "MenuButton",
            targets: ["MenuButton"]),
    ],
    targets: [
        .target(
            name: "MenuButton",
            path: "Sources"),
        
    ]
)
