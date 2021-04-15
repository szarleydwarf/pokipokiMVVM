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
    case responsError(code:String)
    case noData(message:String)
    case decodingError(message:String)
}
protocol NetworkingProtocol {
    func getURL (_ host: String, _ path:String) -> URL?
    func getModels(_ url: URL?) -> Future<Pokiemonies, NetErrors>
}

class Networking: NetworkingProtocol {
    func getURL(_ host: String, _ path: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        return components.url
    }
    
    func getModels(_ url: URL?) -> Future<Pokiemonies, NetErrors> {
        
        return Future<Pokiemonies, NetErrors> {promise in
            guard let url = url else {return promise(.failure(.badURL(message: "URL could not be unwraped"))) }
            URLSession.shared.dataTask(with: url) { (data, respons, error) in
                if let respons = respons as?  HTTPURLResponse, respons.statusCode != 200 {
                    return promise(.failure(.responsError(code: "Session return code > \(respons.statusCode)")))
                }
                
                guard let data = data else { return promise(.failure(.noData(message: "No data downloded")))}
                
                do {
                    guard let result = try? JSONDecoder().decode(Pokiemonies.self, from: data) else {return promise(.failure(.decodingError(message: "Could not decode data")))}
                    DispatchQueue.main.async {
                        return promise(.success(result))
                    }
                }
                
            }.resume()
        }
    }
    
    
}
