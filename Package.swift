// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PortmoneSDKEcom",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "PortmoneSDKEcom",
            targets: ["PortmoneSDKEcom"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "PortmoneSDKEcom",
            path: "Sources/PortmoneSDKEcom.xcframework"
        )
    ]
)
