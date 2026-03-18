//
//  StatGauge.swift
//  Homelab
//
//  Created by Mathieu Dubart on 18/03/2026.
//

import SwiftUI

struct StatGauge: View {
    let title: String
    let value: Double
    let detailText: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Gauge(value: value, in: 0...100) {
                Text(title).font(.caption).bold()
            } currentValueLabel: {
                Text("\(Int(value))%").font(.system(size: 10, design: .monospaced))
            }
            .gaugeStyle(.accessoryCircular)
            .tint(value > 80 ? .red : color)
            .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)
                
                Text(detailText)
                    .font(.system(.subheadline, design: .monospaced))
                    .bold()
            }
            
            Spacer()
        }
        .padding(12)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}
