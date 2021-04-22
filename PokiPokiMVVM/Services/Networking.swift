//
//  Networking.swift
//  PokiPokiMVVM
//
//  Created by The App Experts on 15/04/2021.
//

import Combine
import Foundation

enum NetErrors: Error {
    case badURL(message: String)
    case responsError(code: String)
    case noData(message: String)
    case decodingError(message: String)
}
protocol NetworkingProtocol {
    func getURL (_ host: String, _ path: String) -> URL?
    func getModels<T: Codable>(_ url: URL?) -> Future<T, NetErrors>
    func getImageData(from stringURL: String) -> Data
}

extension NetworkingProtocol {
    func getURL (_ host: String = Const.host, _ path: String = Const.path) -> URL? {
        return getURL(host, path)
    }
}

class Networking: NetworkingProtocol {
    func getURL(_ host: String = Const.host, _ path: String = Const.path) -> URL? {
        var components = URLComponents()
        components.scheme = Const.scheme
        components.host = host
        components.path = path
        return components.url
    }

    func getModels<T: Codable>(_ url: URL?) -> Future<T, NetErrors> {
        return Future<T, NetErrors> {promise in
            guard let url = url else {return promise(.failure(.badURL(message: "URL could not be unwraped"))) }
            URLSession.shared.dataTask(with: url) { (data, respons, _) in
                if let respons = respons as?  HTTPURLResponse, respons.statusCode != 200 {
                    return promise(.failure(.responsError(code: "Session return code > \(respons.statusCode)")))
                }

                guard let data = data else { return promise(.failure(.noData(message: "No data downloded")))}

                do {
                    guard let result = try? JSONDecoder().decode(T.self, from: data)
                    else {return promise(.failure(.decodingError(message: "Could not decode data")))}
                    DispatchQueue.main.async {
                        return promise(.success(result))
                    }
                }
            }.resume()
        }
    }

    func getImageData(from stringURL: String) -> Data {
        guard let url = URL(string: stringURL) else {return Data()}
        guard let data = try? Data(contentsOf: url) else { return Data() }
        return data
    }
}
