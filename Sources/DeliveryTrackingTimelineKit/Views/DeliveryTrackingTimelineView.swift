//
//  DeliveryTrackingTimelineView.swift
//  DeliveryTrackingSystem
//
//  Created by Noman belim on 08/12/25.
//

import Foundation
import SwiftUI
import SwiftUI

public struct DeliveryTrackingTimelineView: View {

    let stages: [DeliveryStage]
    let currentStage: DeliveryStageType

    public init(stages: [DeliveryStage], currentStage: DeliveryStageType) {
        self.stages = stages
        self.currentStage = currentStage
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(stages.enumerated()), id: \.element.id) { idx, stage in
                    TimelineRowView(
                        stage: stage,
                        isFirst: idx == 0,
                        isLast: idx == stages.count - 1
                    )
                }
//                DeliveryTrackingAdminView()
}
            .padding()
        }
        .navigationTitle("Tracking Timeline")
    }
}
class DeliveryTrackingViewModel: ObservableObject {

    @Published var stages: [DeliveryStage] = []
    @Published var showLocationPicker: Bool = false
    @Published var pendingStageUpdate: DeliveryStageType?

    let stageCities: [DeliveryStageType: [String]]   // <-- New

    init(stageCities: [DeliveryStageType: [String]]) {
        self.stageCities = stageCities
        setupInitialStages()
    }

    private func setupInitialStages() {
        stages = DeliveryStageType.allCases.enumerated().map { idx, type in
            DeliveryStage(
                type: type,
                timestamp: idx == 0 ? Date() : nil,
                status: idx == 0 ? .current : .upcoming
            )
        }
    }

    func moveToNextStage(_ stage: DeliveryStageType) {
        if needsLocation(stage) {
            pendingStageUpdate = stage
            showLocationPicker = true
        } else {
            updateStage(stage, city: nil)
        }
    }

    func updateStage(_ stage: DeliveryStageType, city: String?) {
        guard let idx = stages.firstIndex(where: { $0.type == stage }) else { return }

        stages[idx].timestamp = Date()
        stages[idx].status = .completed

        if let city = city {
            let event = TrackingEvent(
                city: city,
                hubName: "\(city) Hub",
                description: "Processed at \(city)",
                arrivalTime: Date()
            )
            stages[idx].events.append(event)
        }

        if idx + 1 < stages.count {
            stages[idx + 1].status = .current
        }
    }

    func citiesForStage(_ type: DeliveryStageType) -> [String] {
        stageCities[type] ?? []  // <-- get correct cities
    }

    private func needsLocation(_ stage: DeliveryStageType) -> Bool {
        switch stage {
        case .arrivedCityHub, .arrivedWarehouse, .inTransit:
            return true
        default:
            return false
        }
    }
}




