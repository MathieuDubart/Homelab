//
//  CoolifyModel.swift
//  Homelab
//
//  Created by Mathieu Dubart on 18/03/2026.
//

import Foundation

struct CoolifyApp: Codable, Identifiable {
    let id: Int
    let uuid: String
    let name: String
    let status: String?
    let type: String?
}
