// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "VLKeyboardKit",
                      platforms: [ .iOS(.v17) ],
                      products:
                      [
                       .library(name: "VLKeyboardKit",
                                targets: ["VLKeyboardKit"])
                      ],
                      targets:
                      [
                       .target(name: "VLKeyboardKit"),
                       .testTarget(name: "VLKeyboardKitTests",
                                   dependencies: ["VLKeyboardKit"])
                      ]
)
