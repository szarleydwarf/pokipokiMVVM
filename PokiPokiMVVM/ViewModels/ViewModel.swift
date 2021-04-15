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

protocol ViewModelDelegate: class {
    func refreshTable()
    func refreshUI()
}

class ViewModel {
    private var observer: AnyCancellable?
    var services: NetworkingProtocol!
    weak var delegate: ViewModelDelegate?
    
    var pokemon:Pokemon? {
        didSet {
            delegate?.refreshUI()
        }
    }
    var pokemonList:Pokiemonies?{
        didSet{
            delegate?.refreshTable()
        }
    }
    
    init (services: NetworkingProtocol = Networking()) {
        self.services = services
    }
    
}

extension ViewModel: ViewModelProtocol {
    func fetchPokemonList() {
        //https://pokeapi.co/api/v2/pokemon/
         if let url = services.getURL("pokeapi.co", "/api/v2/pokemon/") {
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
                    self?.pokemonList = result
                })
        }
    }
    
    func getPokemon(for row: Int) -> Pokemon {
        var pok = Pokemon(id: 1, name: "", baseExperience: 1, height: 1, weight: 1, sprites: nil)
        return pok
    }
    
}

extension ViewModel: ViewModelDelegate {
    func refreshTable() {
        print("vm refreashing table")
    }
    
    func refreshUI() {
        print("vm refreashing UI")
    }
    
    
}
