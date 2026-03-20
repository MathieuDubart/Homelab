//
//  TorBoxItem.swift
//  Homelab
//
//  Created by Mathieu Dubart on 20/03/2026.
//


struct TorBoxItem: Codable, Identifiable {
    let id: Int
    let name: String
    let progress: Double?
    let status: TorBoxStatus
    let size: Int64
    let downloadSpeed: Int64?
    let uploadSpeed: Int64?
    let seeds: Int?
    let peers: Int?
    let eta: Int?
    let ratio: Double?
    let downloadFinished: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, name, progress, size, seeds, peers, eta, ratio
        case status = "download_state"
        case downloadSpeed = "download_speed"
        case uploadSpeed = "upload_speed"
        case downloadFinished = "download_finished"
    }
}
