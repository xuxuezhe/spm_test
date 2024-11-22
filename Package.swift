// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "spm_test",
    platforms: [
        .iOS(.v13) // 플랫폼 및 최소 지원 버전 명시
    ],
    products: [
        .library(name: "spm_test", targets: ["spm_test"]),
        .library(name: "spm_test1", targets: ["spm_test1", "spm_test2"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire", .upToNextMajor(from: "5.10.1")),
        .package(url: "https://github.com/realm/realm-swift", .upToNextMajor(from: "10.54.1"))
    ],
    targets: [
        .target(
            name: "spm_test"),
        
        .target(name: "spm_test1",
                dependencies: [
                    .product(name: "Alamofire", package: "alamofire"),
                    .product(name: "RealmSwift", package: "realm-swift")
                ]
        ),
        
        .target(
            name: "spm_test2"),
        
        .testTarget(
            name: "spm_testTests",
            dependencies: ["spm_test"]),
    ]
)
