// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWSystemStatus",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "WWSystemStatus", targets: ["WWSystemStatus"]),
    ],
    dependencies: [
        .package(url: "https://github.com/William-Weng/WWNetworking.git", from: "1.7.6"),
    ],
    targets: [
        .target(name: "WWSystemStatus", dependencies: ["WWNetworking"], resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
