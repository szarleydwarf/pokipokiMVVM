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
        self.viewModel.delegateMain = self
        self.viewModel.delegateError = self
        self.viewModel.fetchPokemonList()

        self.theTable.dataSource = self
        self.theTable.delegate = self
    }

    @IBAction func refresh(_ sender: UIButton) {
        self.viewModel.fetchPokemonList()
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

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsView = storyboard.instantiateViewController(withIdentifier: "DetailsViewController")
            as? DetailsViewController
        if let urlString = self.viewModel.pokemonList?.results[indexPath.row].url,
           let detailsView = detailsView {
            detailsView.pokeURL = urlString
            self.navigationController!.pushViewController(detailsView, animated: true)
        }
    }
}

extension ViewController: ViewModelDelegateMain {
    func refreshTable() {
        self.theTable.reloadData()
    }
}

extension ViewController: ViewModelErrorsProtocol {
    func displayError(message: String) {
        Toast().displayToast(in: self.view, message: message)
    }
}
