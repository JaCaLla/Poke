//
//  ResultContainerAPI.swift
//  Poke
//
//  Created by Javier Calatrava on 18/11/22.
//

import Foundation

struct ResultContainerAPI: Codable {
    let count: Int
    let results: [PokemonNameAPI]
}

struct PokemonNameAPI: Codable {
    let name: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
    case name = "name"
    case link = "url"
    }
}
