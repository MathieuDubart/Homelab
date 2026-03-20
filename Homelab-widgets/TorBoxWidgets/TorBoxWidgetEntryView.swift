//
//  TorBoxWidgetEntryView.swift
//  Homelab
//
//  Created by Mathieu Dubart on 20/03/2026.
//

import SwiftUI
import WidgetKit
import AppIntents

struct TorBoxWidgetEntryView : View {
    var entry: TorBoxProvider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 4) {
                Image(systemName: "folder.badge.gearshape.fill")
                    .foregroundColor(.blue)
                Text("Storage")
                    .font(.system(size: 14, weight: .heavy, design: .rounded))
                Spacer()
            }
            .padding(.bottom, 6)
            
            if entry.torrents.isEmpty {
                VStack(spacing: 8) {
                    Spacer()
                    Image(systemName: "tray")
                        .font(.system(size: 30))
                        .foregroundColor(.secondary.opacity(0.5))
                    Text("No active downloads")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            } else {
                switch family {
                case .systemSmall:
                    if let torrent = entry.torrents.first {
                        SmallTorBoxRow(torrent: torrent)
                    }
                case .systemMedium:
                    VStack(spacing: 6) {
                        ForEach(entry.torrents.prefix(3)) { torrent in
                            MediumTorBoxRow(torrent: torrent)
                        }
                    }
                default:
                    Text("Unsupported Family")
                }
            }
            Spacer(minLength: 0)
        }
        .padding(.all, 12)
        .containerBackground(Color(.systemBackground), for: .widget)
    }
}
