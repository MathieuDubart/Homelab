//
//  TorBoxIntents.swift
//  Homelab
//
//  Created by Mathieu Dubart on 20/03/2026.
//

import AppIntents

struct DeleteTorrentIntent: AppIntent {
    static var title: LocalizedStringResource = "Delete Torrent"
    
    @Parameter(title: "Torrent ID")
    var id: Int
    
    @Parameter(title: "Torrent Name")
    var name: String
    
    init() {}
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    func perform() async throws -> some IntentResult {
        // 1. Récupérer le token depuis le stockage partagé
        let sharedSuite = UserDefaults(suiteName: "group.fr.mathieu-dubart.homelab")
        let token = sharedSuite?.string(forKey: "torbox_token") ?? ""
        let service = await TorBoxService(token: token)
        
        // 2. Tenter la suppression réelle (silencieusement si erreur)
        try? await service.removeTorrent(id: id)
        
        // 3. Appliquer le filtre persistant (solution d'hier pour le ghost data)
        await DeletedTorrentsManager.instance.markAsDeleted(id: id)
        
        print("🗑️ Widget : Marked \(name) (ID: \(id)) as deleted.")
        
        return .result()
    }
}
