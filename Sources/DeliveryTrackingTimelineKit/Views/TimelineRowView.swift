//
//  TimelineRowView.swift
//  DeliveryTrackingSystem
//
//  Created by Noman belim on 08/12/25.
//

import SwiftUI
import SwiftUI

struct TimelineRowView: View {
    let stage: DeliveryStage
    let isFirst: Bool
    let isLast: Bool

    @State private var expanded: Bool = true

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            indicator

            VStack(alignment: .leading, spacing: 8) {

                header

                if !stage.events.isEmpty {
                    DisclosureGroup(isExpanded: $expanded) {
                        ForEach(stage.events) { event in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(event.description).font(.caption)
                                Text("\(event.city) • \(event.hubName)")
                                    .font(.caption2).foregroundColor(.secondary)
                                if let time = event.arrivalTime {
                                    Text("Arrived: \(timeFormatter.string(from: time))")
                                        .font(.caption2).foregroundColor(.secondary)
                                }
                            }
                            .padding(8)
                            .background(Color(.systemGray6))
                            .cornerRadius(6)
                        }
                    } label: {
                        Text("Shipment Logs (\(stage.events.count))")
                            .font(.caption).foregroundColor(.blue)
                    }
                }

                if !isLast { Divider() }
            }
        }
        .padding(.vertical, 6)
    }

    private var indicator: some View {
        VStack(spacing: 0) {
            if !isFirst {
                Rectangle().frame(width: 2, height: 12).foregroundColor(lineColor)
            }

            ZStack {
                Circle().stroke(lineColor, lineWidth: 2).frame(width: 16, height: 16)

                if stage.status == .completed {
                    Circle().fill(lineColor).frame(width: 10, height: 10)
                } else if stage.status == .current {
                    Circle().fill(.blue).frame(width: 10, height: 10)
                }
            }

            if !isLast {
                Rectangle().frame(width: 2, height: 24).foregroundColor(lineColor)
            }
        }
        .frame(width: 24)
    }

    private var header: some View {
        HStack {
            Text(stage.title)
                .font(.subheadline)
                .fontWeight(stage.status == .current ? .semibold : .regular)
                .foregroundColor(headerColor)

            Spacer()

            if let time = stage.timestamp {
                Text(dateFormatter.string(from: time))
                    .font(.caption).foregroundColor(.secondary)
            }
        }
    }

    private var headerColor: Color {
        switch stage.status {
        case .completed: return .primary
        case .current: return .blue
        case .upcoming: return .secondary
        }
    }

    private var lineColor: Color {
        switch stage.status {
        case .completed: return .green
        case .current: return .blue
        case .upcoming: return .gray.opacity(0.4)
        }
    }

    private var dateFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .short
        return f
    }

    private var timeFormatter: DateFormatter {
        let f = DateFormatter()
        f.timeStyle = .short
        return f
    }
}

 
