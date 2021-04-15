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
    func getPokemon(from url: String)
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
    
    var listCount: Int {
        return pokemonList?.results.count ?? 0
    }
    
    init (services: NetworkingProtocol = Networking()) {
        self.services = services
    }
    
}

extension ViewModel: ViewModelProtocol {
    func fetchPokemonList() {
        //https://pokeapi.co/api/v2/pokemon/
        if let url = services.getURL() {
            observer = services.getModels(url)
                .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case .finished:
                        print("COMPELETED")
                    case .failure(let e):
                        print("ERROR > \(e.localizedDescription)")
                    }
                }, receiveValue: { [weak self] (result) in
                    self?.pokemonList = result
                })
        }
    }
    
    func getPokemon(from url: String) {
        if let url = URL(string: url) {
            print("URL>\(url)")
            observer = services.getModels(url)
                .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case .finished:
                        print("COMPELETED")
                    case .failure(let e):
                        print("ERROR > \(e.localizedDescription)")
                    }
                }, receiveValue: { [weak self] (result) in
                    self?.pokemon = result
                })
            /* Unable to infer type of a closure parameter 'result' in the current context
             # 1st try
            switch result {
            case Pokemon:
                print("pokemon")
            case Pokiemonies:
                print("List")
            default:
                print("who knows?")
            }
             # 2nd try
             if object = result as? Pokemon {
             }else if list = result as? Pokeminies {
             }else{}
             */
        }
    }
    
}
