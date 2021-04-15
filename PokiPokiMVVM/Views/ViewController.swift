//
//  ViewController.swift
//  PokiPokiMVVM
//
//  Created by The App Experts on 15/04/2021.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ViewModel()
        self.viewModel.delegate = self
        self.viewModel.fetchPokemonList()
    }
}

extension ViewController:ViewModelDelegate {
    func refreshTable() {
        print("VC refreashing table")
    }
    
    func refreshUI() {
        print("VC refreashing table")
    }
    
    
}
