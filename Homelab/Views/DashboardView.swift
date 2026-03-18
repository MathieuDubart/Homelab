//
//  DashboardView.swift
//  Homelab
//
//  Created by Mathieu Dubart on 18/03/2026.
//

import SwiftUI

struct DashboardView: View {
    @AppStorage("glances_url") private var glancesUrl: String = ""
    
    @State private var viewModel: DashboardViewModel?
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            Group {
                if glancesUrl.isEmpty || glancesUrl == "https://" {
                    setupRequiredView
                } else if let vm = viewModel {
                    mainDashboard(vm)
                } else {
                    ProgressView(LocalizedStringResource.initialisation)
                }
            }
            .navigationTitle(LocalizedStringResource.systemMonitorTitle)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { showSettings = true } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.blue)
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
            .onAppear {
                refreshViewModel()
            }
            .onChange(of: glancesUrl) { _, _ in
                refreshViewModel()
            }
        }
    }
    
    // MARK: - Sub views
    
    private var setupRequiredView: some View {
        ContentUnavailableView {
            Label(LocalizedStringResource.serverConfiguration, systemImage: "network")
        } description: {
            Text(LocalizedStringResource.enterGlancesUrl)
        } actions: {
            Button(LocalizedStringResource.openSettings) {
                showSettings = true
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    private func mainDashboard(_ vm: DashboardViewModel) -> some View {
        List {
            Section(LocalizedStringResource.systemTitle) {
                VStack(spacing: 12) {
                    StatGauge(
                        title: "CPU",
                        value: vm.cpuUsage,
                        detailText: "\(String(format: "%.1f", vm.cpuUsage))%",
                        color: .indigo
                    )
                    
                    StatGauge(
                        title: "RAM",
                        value: vm.ramUsage,
                        detailText: vm.ramDetailString,
                        color: .green
                    )
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
            
            Section(LocalizedStringResource.servicesTitle) {
                if vm.sortedContainers.isEmpty && !vm.isLoading {
                    Text(LocalizedStringResource.noContainerAvailable)
                        .font(.caption)
                        .foregroundColor(.secondary)
                } else {
                    ForEach(vm.sortedContainers) { container in
                        ContainerRow(container: container)
                            .swipeActions(edge: .trailing) {
                                Button {
                                    
                                } label: {
                                    Label("Restart", systemImage: "arrow.clockwise")
                                }
                                .tint(.orange)
                            }
                    }
                    .animation(.default, value: vm.sortedContainers)
                }
            }
        }
        .refreshable {
            await vm.fetchData()
        }
        .overlay(alignment: .top) {
            if let error = vm.errorMessage {
                errorBanner(error)
            }
        }
    }
    
    private func errorBanner(_ message: String) -> some View {
        Text(message)
            .font(.caption)
            .bold()
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(.red.opacity(0.9))
            .foregroundColor(.white)
            .transition(.move(edge: .top).combined(with: .opacity))
    }
    
    // MARK: - Logique
    
    private func refreshViewModel() {
        if !glancesUrl.isEmpty && glancesUrl != "https://" {
            viewModel?.stopMonitoring()
            viewModel = DashboardViewModel(host: glancesUrl)
            viewModel?.startMonitoring()
        }
    }
}
