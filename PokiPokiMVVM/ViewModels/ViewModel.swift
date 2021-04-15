//
//  ViewModel.swift
//  PokiPokiMVVM
//
//  Created by The App Experts on 15/04/2021.
//
import Combine
import Foundation

protocol ViewModelProtocol {
    func fetchPokemonList()
    func getPokemon(for row: Int) -> Pokemon
}

class ViewModel {
    private var observer: AnyCancellable?
    var services: NetworkingProtocol!
    init (services: NetworkingProtocol = Networking()) {
        self.services = services
    }
    
}

extension ViewModel: ViewModelProtocol {
    func fetchPokemonList() {
        //https://pokeapi.co/api/v2/pokemon/
         if let url = services.getURL("pokeapi.co/api/v2", "pokemon") {
             observer = services.getModels(url)
                .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case .finished:
                    print("COMPELETED")
                    case .failure(let e):
                    print("ERROR > \(e.localizedDescription)")
                    }
                }, receiveValue: { [weak self] (result) in
                    print(result)
                })
        }
    }
    
    func getPokemon(for row: Int) -> Pokemon {
        
        return Pokemon()
    }
    
    
}
