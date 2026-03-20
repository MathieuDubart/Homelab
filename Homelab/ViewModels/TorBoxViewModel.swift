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
        do {
            let freshTorrents = try await service.fetchTorrents()

            let deletedIDs = DeletedTorrentsManager.instance.getDeletedIDs()
            
            let filteredTorrents = freshTorrents.filter { torrent in
                !deletedIDs.contains(torrent.id)
            }
            
            withAnimation {
                self.torrents = filteredTorrents
            }
            
            let fetchedIDs = Set(freshTorrents.map { $0.id })
            DeletedTorrentsManager.instance.clean(keeping: fetchedIDs)
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
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

        withAnimation {
            self.torrents.removeAll { $0.id == id }
        }
        
        DeletedTorrentsManager.instance.markAsDeleted(id: id)
        
        do {
            try await service.removeTorrent(id: id)
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            await loadTorrents()
        } catch {
            print("⚠️ Silently handled TorBox Delete Crash for ID: \(id)")
        }
    }
}
