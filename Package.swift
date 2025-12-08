// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DeliveryTrackingTimelineKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "DeliveryTrackingTimelineKit",
            targets: ["DeliveryTrackingTimelineKit"]
        )
    ],
    targets: [
        .target(
            name: "DeliveryTrackingTimelineKit",
            dependencies: [],
            path: "Sources/DeliveryTrackingTimelineKit",
            resources: [
                // Add icons later if needed
            ]
        ),
        .testTarget(
            name: "DeliveryTrackingTimelineKitTests",
            dependencies: ["DeliveryTrackingTimelineKit"],
            path: "Tests/DeliveryTrackingTimelineKitTests"
        )
    ]
)
