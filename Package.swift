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
        .package(url: "https://github.com/realm/realm-swift", .upToNextMajor(from: "10.54.1")),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift", .upToNextMajor(from: "1.8.3")),
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper", .upToNextMajor(from: "4.4.3")),
//        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON", .upToNextMajor(from: "5.0.2"))
        .package(url: "https://github.com/antitypical/Result", .upToNextMajor(from: "5.0.0")),
//        .package(url: "https://github.com/sunshinejr/SwiftyUserDefaults", .upToNextMajor(from: "5.3.0")),
        .package(url: "https://github.com/sindresorhus/Defaults", .upToNextMajor(from: "7.3.1"))
    ],
    targets: [
        .target(
            name: "spm_test",
            dependencies: [
                .product(name: "Alamofire", package: "alamofire"),
                .product(name: "RealmSwift", package: "realm-swift"),
                .product(name: "CryptoSwift", package: "cryptoswift"),
                .product(name: "ObjectMapper", package: "objectmapper"),
//                .product(name: "SwiftyJSON", package: "swiftyjson")
                .product(name: "Result", package: "result"),
//                .product(name: "SwiftyUserDefaults", package: "swiftyuserdefaults")
                .product(name: "Defaults", package: "defaults")
            ]
        ),
        
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
