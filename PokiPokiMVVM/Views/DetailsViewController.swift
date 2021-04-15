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
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var baseExpLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var widthLabel: UILabel!
    
    
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
        print(poke)
        self.nameLabel.text = poke.name
        self.baseExpLabel.text = "EXP: \(poke.baseExperience)"
        self.heightLabel.text = "H: \(poke.height)"
        self.widthLabel.text = "W: \(poke.weight)"
    }
    
    
}
