//
//  MediumTorBoxRow.swift
//  Homelab
//
//  Created by Mathieu Dubart on 20/03/2026.
//

import SwiftUI
import AppIntents

struct MediumTorBoxRow: View {
    let torrent: TorBoxItem
    
    private let byteCountFormatter: ByteCountFormatter = {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useGB, .useMB]
        formatter.countStyle = .file
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 2) {
            HStack(spacing: 6) {
                Text(torrent.name)
                    .font(.system(size: 12, weight: .semibold))
                    .lineLimit(1)
                Spacer()
                
                HStack(spacing: 4) {
                    Button(intent: DeleteTorrentIntent(id: torrent.id, name: torrent.name)) {
                        Image(systemName: "trash.fill")
                            .font(.system(size: 10))
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)
                    .controlSize(.mini)
                }
            }
            
            HStack(spacing: 6) {
                ProgressView(value: torrent.progress ?? 0)
                    .progressViewStyle(.linear)
                    .tint(torrent.status.color)
                    .frame(height: 2)
                
                Text("\(Int((torrent.progress ?? 0) * 100))%")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(.secondary)
                
                if torrent.status == .downloading, let speed = torrent.downloadSpeed {
                    Text("\(byteCountFormatter.string(fromByteCount: speed))/s")
                        .font(.system(size: 10, design: .monospaced))
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 6)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
}
