//
//  CPUStats.swift
//  Homelab
//
//  Created by Mathieu Dubart on 18/03/2026.
//


import Foundation

/* nonisolated used for strict concurrency */
nonisolated struct CPUStats: Codable, Sendable {
    let total: Double
}

nonisolated struct RAMStats: Codable, Sendable {
    let percent: Double
    let used: Int
    let total: Int
}

nonisolated struct DockerContainer: Codable, Identifiable, Sendable {
    var id: String { name }
    let name: String
    let cpu: Double
    let memory_usage: Int
    let status: String

    enum CodingKeys: String, CodingKey {
        case name, cpu, memory_usage, status
    }
}

nonisolated struct ServerSnapshot: Sendable {
    let cpu: CPUStats
    let ram: RAMStats
    let containers: [DockerContainer]
}
