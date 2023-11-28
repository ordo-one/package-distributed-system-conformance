// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import class Foundation.ProcessInfo
import PackageDescription

let internalDependencies: [String: Range<Version>] = [
    "package-concurrency-helpers": .upToNextMajor(from: "2.0.0"),
]

func makeDependencies() -> [Package.Dependency] {
    let localPath = ProcessInfo.processInfo.environment["LOCAL_PACKAGES_DIR"]
    if let localPath {
        return internalDependencies.map { .package(name: "\($0.key)", path: "\(localPath)/\($0.key)") }
    } else {
        return internalDependencies.map { .package(url: "https://github.com/ordo-one/\($0.key)", $0.value) }
    }
}

let package = Package(
    name: "package-distributed-system-conformance",
    platforms: [
        .macOS(.v14),
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "DistributedSystemConformance",
            type: .dynamic,
            targets: ["DistributedSystemConformance"]
        ),
    ],
    dependencies: makeDependencies(),
    targets: [
        .target(
            name: "DistributedSystemConformance",
            dependencies: [
                "Frostflake",
                .product(name: "Helpers", package: "package-concurrency-helpers"),
            ]
        ),
        .testTarget(
            name: "DistributedSystemConformanceTests"
        ),
        .binaryTarget(
            name: "Frostflake",
            path: "../Frostflake.xcframework"
        )
    ]
)
