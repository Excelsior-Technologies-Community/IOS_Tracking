//
//  TimelineRowView.swift
//  DeliveryTrackingSystem
//
//  Created by Noman belim on 08/12/25.
//

import SwiftUI

struct TimelineRowView: View {

    let stage: DeliveryStage
    let isFirst: Bool
    let isLast: Bool

    @State private var isExpanded: Bool = true

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            timelineIndicator

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(stage.title)
                        .font(.subheadline)
                        .fontWeight(stage.status == .current ? .semibold : .regular)
                        .foregroundColor(colorForStatus(stage.status))

                    Spacer()

                    if let timestamp = stage.timestamp {
                        Text(Self.dateFormatter.string(from: timestamp))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                if !stage.events.isEmpty {
                    DisclosureGroup(
                        isExpanded: $isExpanded,
                        content: {
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(stage.events) { event in
                                    eventRow(event)
                                        .padding(8)
                                        .background(Color(.systemGray6))
                                        .cornerRadius(8)
                                }
                            }
                            .padding(.top, 4)
                        },
                        label: {
                            Text("Shipment logs (\(stage.events.count))")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    )
                }

                Divider()
            }
        }
        .padding(.vertical, 8)
    }

    private var timelineIndicator: some View {
        VStack(spacing: 0) {
            if !isFirst {
                Rectangle()
                    .frame(width: 2, height: 12)
                    .foregroundStyle(lineColor)
            }

            ZStack {
                Circle()
                    .strokeBorder(lineColor, lineWidth: 2)
                    .frame(width: 18, height: 18)

                if stage.status == .completed {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(lineColor)
                } else if stage.status == .current {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.blue)
                }
            }

            if !isLast {
                Rectangle()
                    .frame(width: 2, height: 24)
                    .foregroundStyle(lineColor)
            }
        }
        .frame(width: 24)
    }

    private var lineColor: Color {
        switch stage.status {
        case .completed:
            return .green
        case .current:
            return .blue
        case .upcoming:
            return .gray.opacity(0.4)
        }
    }

    private func colorForStatus(_ status: StageStatus) -> Color {
        switch status {
        case .completed:
            return .primary
        case .current:
            return .blue
        case .upcoming:
            return .secondary
        }
    }

    private func eventRow(_ event: TrackingEvent) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(event.description)
                .font(.caption)
                .fontWeight(.medium)

            Text("\(event.city) • \(event.hubName)")
                .font(.caption2)
                .foregroundColor(.secondary)

            if event.arrivalTime != nil || event.departureTime != nil {
                HStack(spacing: 8) {
                    if let arrival = event.arrivalTime {
                        Text("Arrived: \(Self.timeFormatter.string(from: arrival))")
                            .font(.caption2)
                    }
                    if let departure = event.departureTime {
                        Text("Departed: \(Self.timeFormatter.string(from: departure))")
                            .font(.caption2)
                    }
                }
                .foregroundColor(.secondary)
            }
        }
    }

    // MARK: - Formatters

    private static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df
    }()

    private static let timeFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .none
        df.timeStyle = .short
        return df
    }()
}
 
