//
//  DeliveryStage.swift
//  DeliveryTrackingSystem
//
//  Created by Noman belim on 08/12/25.
//

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

public struct DeliveryStage: Identifiable {
    public let id: UUID
    public let type: DeliveryStageType
    public let title: String
    public let timestamp: Date?
    public let status: StageStatus
    /// Detailed shipment logs for this stage (for stages after `shipped`)
    public let events: [TrackingEvent]

    public init(
        id: UUID = UUID(),
        type: DeliveryStageType,
        title: String? = nil,
        timestamp: Date? = nil,
        status: StageStatus,
        events: [TrackingEvent] = []
    ) {
        self.id = id
        self.type = type
        self.title = title ?? type.rawValue
        self.timestamp = timestamp
        self.status = status
        self.events = events
    }
}
