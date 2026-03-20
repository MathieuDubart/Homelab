//
//  SettingsView.swift
//  Homelab
//
//  Created by Mathieu Dubart on 18/03/2026.
//


import SwiftUI

struct SettingsView: View {
    @AppStorage("glances_url", store: UserDefaults(suiteName: "group.fr.mathieu-dubart.homelab")) private var glancesUrl: String = "https://"
    @AppStorage("coolify_token", store: UserDefaults(suiteName: "group.fr.mathieu-dubart.homelab")) private var coolifyToken: String = ""
    @AppStorage("coolify_url", store: UserDefaults(suiteName: "group.fr.mathieu-dubart.homelab")) private var coolifyUrl: String = "https://"
    @AppStorage("torbox_token", store: UserDefaults(suiteName: "group.fr.mathieu-dubart.homelab"))var torboxToken: String = ""
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text(LocalizedStringResource.serverConfiguration), footer:Text(LocalizedStringResource.cloudflareTunnelExempleUrl)) {
                    TextField(LocalizedStringResource.cloudflareTunnelExempleUrl, text: $glancesUrl)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .keyboardType(.URL)
                }
                
                Section(header: Text(LocalizedStringResource.coolifyApi), footer:Text(LocalizedStringResource.generableInCoolifyInstance)) {
                    TextField(LocalizedStringResource.cloudflareTunnelExempleUrl, text: $coolifyUrl)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .keyboardType(.URL)
                    
                    SecureField(LocalizedStringResource.apiToken, text: $coolifyToken)
                    
                }

                
                Section(header: Text(LocalizedStringResource.torboxStorage), footer: Text(LocalizedStringResource.apiTokenCanBeFoundOnTorbox)) {
                    SecureField(LocalizedStringResource.apiToken, text: $torboxToken)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
            }
            .navigationTitle(LocalizedStringResource.parameters)
        }
    }
}
