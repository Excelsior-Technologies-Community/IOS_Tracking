//
//  DeliveryStage.swift
//  DeliveryTrackingSystem
//
//  Created by Noman belim on 08/12/25.
//

import Foundation
import Foundation
import Foundation

public enum DeliveryStageType: String, CaseIterable, Identifiable {
    case ordered = "Ordered"
    case packed = "Packed"
    case shipped = "Shipped"
    case inTransit = "In-Transit"
    case arrivedCityHub = "Arrived at City Hub"
    case arrivedWarehouse = "Arrived at Warehouse"
    case outForDelivery = "Out for Delivery"
    case delivered = "Delivered"

    public var id: String { rawValue }
}

public enum StageStatus {
    case completed
    case current
    case upcoming
}

public struct TrackingEvent: Identifiable {
    public let id = UUID()
    public let city: String
    public let hubName: String
    public let description: String
    public let arrivalTime: Date?

    public init(
        city: String,
        hubName: String,
        description: String,
        arrivalTime: Date? = nil
    ) {
        self.city = city
        self.hubName = hubName
        self.description = description
        self.arrivalTime = arrivalTime
    }
}

public struct DeliveryStage: Identifiable {
    public let id = UUID()
    public let type: DeliveryStageType
    public let title: String
    public var timestamp: Date?
    public var status: StageStatus
    public var events: [TrackingEvent]

    public init(
        type: DeliveryStageType,
        title: String? = nil,
        timestamp: Date? = nil,
        status: StageStatus,
        events: [TrackingEvent] = []
    ) {
        self.type = type
        self.title = title ?? type.rawValue
        self.timestamp = timestamp
        self.status = status
        self.events = events
    }
}
