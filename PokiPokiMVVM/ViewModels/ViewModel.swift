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

protocol ViewModelDelegateMain: class {
    func refreshTable()
}

protocol ViewModelDelegateDetails: class {
    func refreshUI(with pokiemon: Pokemon?)
    func setImage(using data:Data?)
}

class ViewModel {
    private var observer: AnyCancellable?
    var services: NetworkingProtocol!
    weak var delegateMain: ViewModelDelegateMain?
    weak var delegateDetails: ViewModelDelegateDetails?
    
    private var pokemon:Pokemon? {
        didSet {
            delegateDetails?.refreshUI(with: self.pokemon)
            self.getSpriteData()
        }
    }
    
   private var pokemonSpriteData: Data? {
        didSet{
            delegateDetails?.setImage(using: self.pokemonSpriteData)
        }
    }
    
    
    
    var pokemonList:Pokiemonies?{
        didSet{
            delegateMain?.refreshTable()
        }
    }
    
    var listCount: Int {
        return pokemonList?.results.count ?? 0
    }
    
    init (services: NetworkingProtocol = Networking()) {
        self.services = services
    }
 
    func getSpriteData() {
        guard let stringUrl = self.pokemon?.sprites?.frontDefault, let url = URL(string: stringUrl) else {return}
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                self?.pokemonSpriteData = data
            }
        }
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
