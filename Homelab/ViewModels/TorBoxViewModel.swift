//
//  TorBoxViewModel.swift
//  Homelab
//
//  Created by Mathieu Dubart on 20/03/2026.
//


import Foundation
import Combine
import SwiftUI

@MainActor
class TorBoxViewModel: ObservableObject {
    @Published var torrents: [TorBoxItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    let service: TorBoxService
    
    init(token: String) {
        self.service = TorBoxService(token: token)
    }
    
    func loadTorrents() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        
        do {
            self.torrents = try await service.fetchTorrents()
        } catch {
            errorMessage = "\(LocalizedStringResource.failedToLoadTorrents): \(error.localizedDescription)"
            print("\(LocalizedStringResource.failedToLoadTorrents): \(error)")
        }
        
        isLoading = false
    }
    
    func pauseTorrent(id: Int) async {
        do {
            try await service.pauseTorrent(id: id)
        } catch {
            errorMessage = "Failed to pause torrent: \(error.localizedDescription)"
        }
        await loadTorrents()
    }
    
    func resumeTorrent(id: Int) async {
        do {
            try await service.resumeTorrent(id: id)
        } catch {
            errorMessage = "Failed to resume torrent: \(error.localizedDescription)"
        }
        await loadTorrents()
    }
    
    func removeTorrent(id: Int) async {
        do {
            try await service.removeTorrent(id: id)
        } catch {
            errorMessage = "Failed to remove torrent: \(error.localizedDescription)"
        }
        await loadTorrents()
    }
}
