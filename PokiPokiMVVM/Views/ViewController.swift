//
//  ViewController.swift
//  PokiPokiMVVM
//
//  Created by The App Experts on 15/04/2021.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: ViewModel!
    @IBOutlet weak var theTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ViewModel()
        self.viewModel.delegate = self
        self.viewModel.fetchPokemonList()
        
        self.theTable.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.listCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.theTable.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        
        let record = self.viewModel.pokemonList?.results[indexPath.row]
        cell.textLabel?.text = record?.name
        
        return cell
    }
    
    
}

extension ViewController:ViewModelDelegate {
    func refreshTable() {
        print("VC refreashing table")
        self.theTable.reloadData()
    }
    
    func refreshUI() {
        print("VC refreashing table")
    }
    
    
}
