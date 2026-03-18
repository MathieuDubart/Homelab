//
//  CoolifyResource.swift
//  Homelab
//
//  Created by Mathieu Dubart on 18/03/2026.
//


import Foundation

struct CoolifyServiceResource: Codable, Identifiable {
    let uuid: String
    let name: String
    let status: String?
    
    var id: String { uuid }
}
