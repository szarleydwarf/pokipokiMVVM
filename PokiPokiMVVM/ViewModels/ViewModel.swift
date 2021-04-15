//
//  ViewModel.swift
//  PokiPokiMVVM
//
//  Created by The App Experts on 15/04/2021.
//
import Combine
import Foundation

class ViewModel {
    private var observer: AnyCancellable?
    
    //https://pokeapi.co/api/v2/pokemon/
    func fetchData() {
        if let url = Networking().getURL("pokeapi.co/api/v2", "pokemon") {
             observer = Networking().getModels(url)
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
    
}
