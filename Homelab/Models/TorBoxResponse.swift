//
//  TorBoxResponse.swift
//  Homelab
//
//  Created by Mathieu Dubart on 20/03/2026.
//


struct TorBoxResponse: Codable {
    let success: Bool
    let data: [TorBoxItem]
}