//
//  Pokemons.swift
//  PokiPokiMVVM
//
//  Created by The App Experts on 15/04/2021.
//

import Foundation

struct Pokiemonies: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let name: String
    let url: String
}

// MARK: - Model
struct Pokemon: Codable {
    let pokiID: Int
    let name: String
    let baseExperience: Int
    let height: Int
    let weight: Int
    let sprites: Sprites?

    enum CodingKeys: String, CodingKey {
            case pokiID, name, height, weight, sprites
            case baseExperience = "base_experience"
        }
}

class Sprites: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
