//
//  TorBoxRow.swift
//  Homelab
//
//  Created by Mathieu Dubart on 20/03/2026.
//


import SwiftUI

struct TorBoxRow: View {
    let torrent: TorBoxItem
    
    private let byteCountFormatter: ByteCountFormatter = {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useGB, .useMB]
        formatter.countStyle = .file
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(torrent.name)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .lineLimit(1)
                Spacer()
                Text(torrent.status.rawValue.capitalized)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(torrent.status.color)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(torrent.status.color.opacity(0.1))
                    .cornerRadius(6)
            }
            
            HStack {
                ProgressView(value: torrent.progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: torrent.status.color))
                
                Text("\(Int((torrent.progress ?? 0) * 100))%")
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Text(byteCountFormatter.string(fromByteCount: torrent.size))
                    .font(.system(size: 12))
                
                Spacer()
                
                if torrent.status == .downloading, let speed = torrent.downloadSpeed {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.down.circle")
                            .font(.system(size: 10))
                        Text("\(byteCountFormatter.string(fromByteCount: speed))/s")
                            .font(.system(size: 12, design: .monospaced))
                    }
                    .foregroundColor(torrent.status.color)
                }
            }
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}
