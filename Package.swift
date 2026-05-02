// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CapacitorSecureKeyStorage",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CapacitorSecureKeyStorage",
            targets: ["SecureKeyStoragePlugin"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", exact: "8.0.0")
    ],
    targets: [
        .target(
            name: "SecureKeyStoragePlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/SecureKeyStoragePlugin"
        )
    ]
)
