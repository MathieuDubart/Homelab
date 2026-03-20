//
//  MainTabView.swift
//  Homelab
//
//  Created by Mathieu Dubart on 20/03/2026.
//


import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Tab = .dashboard
    
    enum Tab {
        case dashboard
        case containers
        case storage
        case settings
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            NavigationStack {
                DashboardView()
            }
            .tabItem {
                Label {
                    Text(LocalizedStringResource.dashboard)
                } icon: {
                    Image(systemName: "gauge.with.needle")
                }
            }
            .tag(Tab.dashboard)
            
            NavigationStack {
                TorBoxView()
            }
            .tabItem {
                Label {
                    Text(LocalizedStringResource.storage)
                } icon: {
                    Image(systemName: "folder.badge.gearshape")
                }
            }
            .tag(Tab.storage)
            
            
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label {
                    Text(LocalizedStringResource.settings)
                } icon: {
                    Image(systemName: "gear")
                }
            }
            .tag(Tab.settings)
        }
        .tint(.blue) 
    }
}
