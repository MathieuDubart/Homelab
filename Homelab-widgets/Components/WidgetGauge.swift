//
//  StatGauge.swift
//  Homelab
//
//  Created by Mathieu Dubart on 18/03/2026.
//

import SwiftUI

struct WidgetGauge: View {
    let label: String
    let value: Double
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(label)
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(Int(value))%")
                    .font(.system(size: 12, weight: .heavy, design: .monospaced))
                    .foregroundColor(value > 80 ? .red : .primary)
            }
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(color.opacity(0.2))
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(value > 80 ? Color.red : color)
                        .frame(width: geo.size.width * CGFloat(min(value / 100, 1.0)), height: 8)
                }
            }
            .frame(height: 8)
        }
    }
}
