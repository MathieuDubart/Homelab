//
//  ContainerRow.swift
//  Homelab
//
//  Created by Mathieu Dubart on 18/03/2026.
//


import SwiftUI

struct ContainerRow: View {
    let container: DockerContainer
    
    private let cpuCriticalThreshold = 80.0
    private let ramCriticalThresholdBytes = 1_024_000_000 // 1 GB
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 6) {
                Text(container.name)
                    .font(.headline)
                    .lineLimit(1)
                
                statusBadge
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: "memorychip")
                    Text(formattedMemory)
                }
                .font(.system(.caption, design: .monospaced))
                .fontWeight(isRamCritical ? .bold : .regular)
                .foregroundColor(isRamCritical ? .red : .secondary)
                
                
                HStack(spacing: 4) {
                    Image(systemName: "cpu")
                    Text("\(String(format: "%.1f", container.cpu ?? 0))%")
                }
                .font(.system(.caption, design: .monospaced))
                .fontWeight(isCpuCritical ? .bold : .regular)
                .foregroundColor(isCpuCritical ? .red : .secondary)
            }
        }
        .padding(.vertical, 4)
    }
    
    // MARK: - Sub views & Helpers
    
    private var statusBadge: some View {
        Text(container.status.capitalized)
            .font(.system(size: 10, weight: .bold, design: .monospaced))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(isHealthy ? Color.green.opacity(0.15) : Color.orange.opacity(0.15))
            .foregroundColor(isHealthy ? .green : .orange)
            .clipShape(Capsule())
            .overlay(
                Capsule().stroke(isHealthy ? Color.green.opacity(0.3) : Color.orange.opacity(0.3), lineWidth: 1)
            )
    }
    
    private var formattedMemory: String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useMB, .useGB]
        formatter.countStyle = .memory
        return formatter.string(fromByteCount: Int64(container.memoryUsage ?? 0))
    }
    
    private var isHealthy: Bool {
        let status = container.status.lowercased()
        return status.contains("healthy") || status.contains("up")
    }
    
    private var isCpuCritical: Bool {
        (container.cpu ?? 0) >= cpuCriticalThreshold
    }
    
    private var isRamCritical: Bool {
        (container.memoryUsage ?? 0) >= ramCriticalThresholdBytes
    }
}
