//
//  GlancesService.swift
//  Homelab
//
//  Created by Mathieu Dubart on 18/03/2026.
//

import Foundation

final class GlancesService: Sendable {
    private let baseURL: URL
    private let apiRoute: String
    
    init(host: String, apiVersion: String) {
        self.baseURL = URL(string: host)!
        self.apiRoute = "/api/\(apiVersion)/"
    }
    
    func fetchFullSnapshot() async throws -> ServerSnapshot {
        async let cpuReq = fetch(endpoint: "cpu") as CPUStats
        async let ramReq = fetch(endpoint: "mem") as RAMStats
        async let dockerReq = fetch(endpoint: "containers") as [DockerContainer]
        
        return try await ServerSnapshot(
            cpu: cpuReq,
            ram: ramReq,
            containers: dockerReq
        )
    }
    
    /* T is used for generics. Type needs to conform to Codable & Sendable */
    private func fetch<T: Codable & Sendable>(endpoint: String) async throws -> T {
        let url = baseURL.appendingPathComponent(apiRoute)
                            .appendingPathComponent(endpoint)
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
