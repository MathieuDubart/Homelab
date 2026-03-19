//
//  DashboardView.swift
//  Homelab
//
//  Created by Mathieu Dubart on 18/03/2026.
//

import SwiftUI

struct DashboardView: View {
    
    @AppStorage("glances_url", store: UserDefaults(suiteName: "group.fr.mathieu-dubart.homelab"))
    private var glancesUrl: String = ""
    @AppStorage("coolify_token", store: UserDefaults(suiteName: "group.fr.mathieu-dubart.homelab")) private var coolifyToken: String = ""
    @AppStorage("coolify_url", store: UserDefaults(suiteName: "group.fr.mathieu-dubart.homelab")) private var coolifyUrl: String = ""
    
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
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button {
                                    performAction(.restart, for: container)
                                } label: {
                                    Label("Restart", systemImage: "arrow.clockwise")
                                }
                                .tint(.orange)
                                
                                if container.status.contains("Up") {
                                    Button(role: .destructive) {
                                        performAction(.stop, for: container)
                                    } label: {
                                        Label("Stop", systemImage: "stop.fill")
                                    }
                                } else {
                                    Button {
                                        performAction(.start, for: container)
                                    } label: {
                                        Label("Start", systemImage: "play.fill")
                                    }
                                    .tint(.green)
                                }
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
    
    private func performAction(_ action: CoolifyService.Action, for container: DockerContainer) {
        let service = CoolifyService(host: coolifyUrl, token: coolifyToken)
        
        Task {
            do {
                try await service.execute(action: action, for: container.name)
                
            } catch {
                print("Error on action \(action) for container \(container.name): \(error)")
            }
        }
    }
}
