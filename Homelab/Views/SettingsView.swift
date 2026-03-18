//
//  SettingsView.swift
//  Homelab
//
//  Created by Mathieu Dubart on 18/03/2026.
//


import SwiftUI

struct SettingsView: View {
    @AppStorage("glances_url") private var glancesUrl: String = "https://"
    @AppStorage("coolify_token") private var coolifyToken: String = ""
    @AppStorage("coolify_url") private var coolifyUrl: String = "https://"
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text(LocalizedStringResource.serverConfiguration)) {
                    TextField(LocalizedStringResource.cloudflareTunnelExempleUrl, text: $glancesUrl)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .keyboardType(.URL)
                    
                    Text(LocalizedStringResource.cloudflareTunnelExempleUrl)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Section(header: Text(LocalizedStringResource.coolifyApi)) {
                    TextField(LocalizedStringResource.cloudflareTunnelExempleUrl, text: $coolifyUrl)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .keyboardType(.URL)
                    
                    SecureField(LocalizedStringResource.apiToken, text: $coolifyToken)
                    Text(LocalizedStringResource.generableInCoolifyInstance)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Section {
                    Button(LocalizedStringResource.saveAndClose) {
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .alignmentGuide(.leading) { _ in 0 }
                }
            }
            .navigationTitle(LocalizedStringResource.parameters)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("OK") { dismiss() }
                }
            }
        }
    }
}
