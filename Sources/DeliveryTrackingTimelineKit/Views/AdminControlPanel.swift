//
//  AdminControlPanel.swift
//  DeliveryTrackingSystem
//
//  Created by Noman belim on 09/12/25.
//

import SwiftUI
import SwiftUI

struct AdminControlPanel: View {
    @ObservedObject var viewModel: DeliveryTrackingViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Update Delivery Status")
                .font(.headline)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(DeliveryStageType.allCases) { type in
                        StageButton(
                            stageType: type,
                            isCompleted: stage(type)?.status == .completed,
                            isCurrent: stage(type)?.status == .current
                        ) {
                            viewModel.moveToNextStage(type)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
        .background(Color(.systemGray6))
    }

    private func stage(_ type: DeliveryStageType) -> DeliveryStage? {
        viewModel.stages.first(where: { $0.type == type })
    }
}

struct StageButton: View {
    let stageType: DeliveryStageType
    let isCompleted: Bool
    let isCurrent: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(isCompleted ? .green : isCurrent ? .blue : .gray)

                Text(stageType.rawValue)
                    .font(.caption)
                    .foregroundColor(isCompleted ? .green : isCurrent ? .blue : .primary)
            }
            .frame(width: 90)
            .padding(.vertical, 8)
            .background(isCurrent ? Color.blue.opacity(0.15) : .clear)
            .cornerRadius(8)
        }
        .disabled(isCompleted)
    }
}

struct LocationPickerSheet: View {
    @ObservedObject var viewModel: DeliveryTrackingViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            List(viewModel.apiCities, id: \.self) { city in
                Button {
                    if let pending = viewModel.pendingStageUpdate {
                        viewModel.updateStage(pending, city: city)
                    }
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "mappin.circle.fill").foregroundColor(.blue)
                        Text(city)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
            }
            .navigationTitle("Choose Hub Location")
        }
    }
}


public struct DeliveryTrackingAdminView: View {

    @StateObject private var viewModel: DeliveryTrackingViewModel
    private var apiCities: [String]

    public init(_ cities: [String]) {
        self.apiCities = cities
        _viewModel = StateObject(wrappedValue: DeliveryTrackingViewModel(cities: cities))
    }

    public var body: some View {
        NavigationView {
            VStack(spacing: 0) {

                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(Array(viewModel.stages.enumerated()), id: \.element.id) { idx, stage in
                            TimelineRowView(
                                stage: stage,
                                isFirst: idx == 0,
                                isLast: idx == viewModel.stages.count - 1
                            )
                        }
                    }
                    .padding()
                }

                Divider()
                AdminControlPanel(viewModel: viewModel)
            }
            .navigationTitle("Delivery Tracking")
            .sheet(isPresented: $viewModel.showLocationPicker) {
                LocationPickerSheet(viewModel: viewModel)
            }
        }
    }
}


 
