//
//  TorBoxEntry.swift
//  Homelab
//
//  Created by Mathieu Dubart on 20/03/2026.
//
import WidgetKit

struct TorBoxEntry: TimelineEntry {
    let date: Date
    let torrents: [TorBoxItem]
}
