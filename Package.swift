// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TenorRepository",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "TenorRepository",
            targets: ["TenorRepository"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Yabby1997/GIFPediaService", from: "0.4.0"),
        .package(url: "https://github.com/Yabby1997/SHNetworkServiceInterface", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "TenorRepository",
            dependencies: [
                .product(name: "GIFPediaService", package: "GIFPediaService"),
                .product(name: "SHNetworkServiceInterface", package: "SHNetworkServiceInterface"),
            ]),
    ]
)
