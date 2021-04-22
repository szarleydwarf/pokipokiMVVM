//
//  ViewModel.swift
//  PokiPokiMVVM
//
//  Created by The App Experts on 15/04/2021.
//
import Combine
import Foundation

protocol ViewModelListProtocol {
    func fetchPokemonList()
}

protocol ViewModelPokemoneProtocol {
    func getPokemon(from url: String)
}

protocol ViewModelDelegateMain: class {
    func refreshTable()
}

protocol ViewModelDelegateDetails: class {
    func refreshUI(with pokiemon: Pokemon?)
    func setImage(using data: Data?)
}

protocol ViewModelErrorsProtocol: class {
    func displayError(message: String)
}

class ViewModel {
    private var observer: AnyCancellable?
    var services: NetworkingProtocol!
    weak var delegateMain: ViewModelDelegateMain?
    weak var delegateDetails: ViewModelDelegateDetails?
    weak var delegateError: ViewModelErrorsProtocol?

    private var pokemon: Pokemon? {
        didSet {
            delegateDetails?.refreshUI(with: self.pokemon)
            self.getSpriteData()
        }
    }

    private var pokemonSpriteData: Data? {
        didSet {
            delegateDetails?.setImage(using: self.pokemonSpriteData)
        }
    }

    var pokemonList: Pokiemonies? {
        didSet {
            delegateMain?.refreshTable()
        }
    }

    var listCount: Int {
        return pokemonList?.results.count ?? 0
    }

    var error: String? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.delegateError?.displayError(message: self?.error ?? "ERROR UNKOWN!")
            }
        }
    }

    init (services: NetworkingProtocol = Networking()) {
        self.services = services
    }

    func getSpriteData() {
        if let stringURL = self.pokemon?.sprites?.frontDefault {
            DispatchQueue.global().async { [weak self] in
                self?.pokemonSpriteData = self?.services.getImageData(from: stringURL)
            }
        }
    }
}

extension ViewModel: ViewModelListProtocol {
    func fetchPokemonList() {
        //https://pokeapi.co/api/v2/pokemon/
        if let url = services.getURL() {
            observer = services.getModels(url)
                .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case .finished:
                        print("COMPELETED")
                    case .failure(let err):
                        self.error = err.localizedDescription
                        print("ERROR > \(err.localizedDescription)")
                    }
                }, receiveValue: { [weak self] (result) in
                    self?.pokemonList = result
                })
        }
    }
}

extension ViewModel: ViewModelPokemoneProtocol {
    func getPokemon(from url: String) {
        if let url = URL(string: url) {
            print("URL>\(url)")
            observer = services.getModels(url)
                .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case .finished:
                        print("COMPELETED")
                    case .failure(let err):
                        self.error = "ERROR > \(err.localizedDescription)"
                        print("ERROR > \(err.localizedDescription)")
                    }
                }, receiveValue: { [weak self] (result) in
                    self?.pokemon = result
                })
        }
    }

}
