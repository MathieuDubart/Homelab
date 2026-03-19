//
//  ContainerRow.swift
//  Homelab
//
//  Created by Mathieu Dubart on 19/03/2026.
//
import SwiftUI

struct ContainerRow: View {
    let container: WidgetContainer
    
    var body: some View {
        HStack {
            Text(container.name)
                .font(.system(size: 10, weight: .medium))
                .lineLimit(1)
            Spacer()
            Text("\(Int(container.memoryUsage))MB")
                .font(.system(size: 10, design: .monospaced))
                .foregroundColor(container.memoryUsage > 1000 ? .red : .secondary)
        }
    }
}
