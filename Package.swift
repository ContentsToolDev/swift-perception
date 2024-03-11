// swift-tools-version: 5.9

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "swift-perception",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
    .tvOS(.v13),
    .watchOS(.v6),
  ],
  products: [
    .library(name: "Perception", targets: ["Perception"])
  ],
  dependencies: [
    .package(url: "https://github.com/ContentsToolDev/swift-syntax-xcframeworks", branch: "main"),
    .package(url: "https://github.com/apple/swift-collections", from: "1.0.0"),
    .package(url: "https://github.com/ContentsToolDev/swift-macro-testing", branch: "main"),
    .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "1.0.0"),
  ],
  targets: [
    .target(
      name: "Perception",
      dependencies: [
        "PerceptionMacros",
        .product(name: "OrderedCollections", package: "swift-collections"),
        .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
      ]
    ),
    .testTarget(name: "PerceptionTests", dependencies: ["Perception"]),

    .macro(
      name: "PerceptionMacros",
      dependencies: [
        .product(name: "SwiftSyntaxWrapper", package: "swift-syntax-xcframeworks"),
      ]
    ),
    .testTarget(
      name: "PerceptionMacrosTests",
      dependencies: [
        "PerceptionMacros",
        .product(name: "MacroTesting", package: "swift-macro-testing"),
      ]
    ),
  ]
)
