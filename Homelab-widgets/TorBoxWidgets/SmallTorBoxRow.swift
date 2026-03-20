//
//  SmallTorBoxRow.swift
//  Homelab
//
//  Created by Mathieu Dubart on 20/03/2026.
//

import SwiftUI
import AppIntents

struct SmallTorBoxRow: View {
    let torrent: TorBoxItem
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
                .frame(height: 8)
            HStack {
                VStack {
                    ZStack {
                        Circle()
                            .stroke(torrent.status.color.opacity(0.1), lineWidth: 4)
                        Circle()
                            .trim(from: 0, to: CGFloat(torrent.progress ?? 0))
                            .stroke(torrent.status.color, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                        Text("\(Int((torrent.progress ?? 0) * 100))%")
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                            .foregroundColor(torrent.status.color)
                    }
                    .frame(width: 36, height: 36)
                    
                    Spacer()
                        .frame(width: 18)
                    
                    Text(ByteCountFormatter().string(fromByteCount: torrent.size))
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 1)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(4)
                }
                
                Spacer()
                
                Text(torrent.name)
                    .font(.system(size: 11, weight: .bold))
                    .lineLimit(4)
            }
            
            Spacer()
            
            Button(intent: DeleteTorrentIntent(id: torrent.id, name: torrent.name)) {
                Image(systemName: "trash.fill")
                    .font(.system(size: 20))
            }
            .frame(width: 120)
            .frame(height: 28)
            .foregroundColor(.red)
            .padding(.vertical, 6)
            .background(.red.opacity(0.1))
            .cornerRadius(8)
            .buttonStyle(.plain)
            .tint(.red)
            .controlSize(.regular)
        }
    }
}
