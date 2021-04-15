//
//  Networking.swift
//  PokiPokiMVVM
//
//  Created by The App Experts on 15/04/2021.
//

import Combine
import Foundation

enum NetErrors: Error {
    case badURL(message:String)
    
}
protocol NetworkingProtocol {
    func getURL (_ host: String, _ path:String) -> URL?
    func getModels(_ url: URL?) -> Future<Pokiemonies, NetErrors>
}

class Networking: NetworkingProtocol {
    func getURL(_ host: String, _ path: String) -> URL? {
        
    }
    
    func getModels(_ url: URL?) -> Future<Pokiemonies, NetErrors> {
        
    }
    
    
}
