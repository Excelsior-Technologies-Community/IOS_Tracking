//
//  DeliveryTrackingTimelineView.swift
//  DeliveryTrackingSystem
//
//  Created by Noman belim on 08/12/25.
//

import Foundation
import SwiftUI

public struct DeliveryTrackingTimelineView: View {

    private let stages: [DeliveryStage]
    private let currentStage: DeliveryStageType
    private let isLoading: Bool
    private let onRefresh: (() -> Void)?

    public init(
        stages: [DeliveryStage],
        currentStage: DeliveryStageType,
        isLoading: Bool = false,
        onRefresh: (() -> Void)? = nil
    ) {
        self.stages = stages
        self.currentStage = currentStage
        self.isLoading = isLoading
        self.onRefresh = onRefresh
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            headerSection

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(Array(stages.enumerated()), id: \.element.id) { index, stage in
                        TimelineRowView(
                            stage: stage,
                            isFirst: index == 0,
                            isLast: index == stages.count - 1
                        )
                    }
                }
                .padding(.top, 8)
            }
        }
        .padding()
    }

    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Delivery Status")
                    .font(.headline)

                Text(statusDescription(currentStage))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            if isLoading {
                ProgressView()
            } else if let onRefresh = onRefresh {
                Button(action: onRefresh) {
                    Image(systemName: "arrow.clockwise")
                }
                .buttonStyle(.bordered)
            }
        }
    }

    private func statusDescription(_ status: DeliveryStageType) -> String {
        switch status {
        case .ordered:
            return "We’ve received your order."
        case .packed:
            return "Your items are packed."
        case .shipped:
            return "Your order has left the warehouse."
        case .inTransit:
            return "Your order is on the way."
        case .arrivedCityHub:
            return "Arrived at your city’s hub."
        case .arrivedWarehouse:
            return "Arrived at local warehouse."
        case .outForDelivery:
            return "Our delivery partner is on the way."
        case .delivered:
            return "Order delivered."
        }
    }
}

