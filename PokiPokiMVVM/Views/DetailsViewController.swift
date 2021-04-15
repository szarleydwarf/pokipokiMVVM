//
//  DetailsViewController.swift
//  PokiPokiMVVM
//
//  Created by The App Experts on 15/04/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    var pokeURL:String?
    var viewModel:ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ViewModel()
        self.viewModel.delegateDetails = self
  
        print("DVC > \(pokeURL)")
        if let url = pokeURL  {
            self.viewModel.getPokemon(from: url)
        }
    }

}
extension DetailsViewController: ViewModelDelegateDetails {
    func refreshUI() {
        guard let poke = self.viewModel.pokemon else {return}
        print(poke.name)
    }
    
    
}
