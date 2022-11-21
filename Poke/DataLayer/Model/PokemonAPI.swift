//
//  PokemonAPI.swift
//  Poke
//
//  Created by Javier Calatrava on 18/11/22.
//

import Foundation

struct PokemonAPI: Codable {
    let id: Int
    let name: String
    let sprites: SpritesAPI
}

struct SpritesAPI: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
    case frontDefault = "front_default"
    }
}
