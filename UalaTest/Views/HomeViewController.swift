//
//  HomeViewController.swift
//  UalaTest
//
//  Created by Pedro Iván Romero Ojeda on 1/23/21.
//  Copyright © 2021 piro. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: HomeViewModel?
    weak var coordinator: HomeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Buscador"
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel?.updateMeals = { [weak self] in
            if let viewModel = self?.viewModel, viewModel.itemsCount() == 0 {
                self?.showAlertNoItems()
            }
            self?.tableView.reloadData()
        }
        
        viewModel?.isLoading = { [weak self] isLoading in
            self?.activityIndicator.isHidden = !isLoading
        }
        
        viewModel?.isError = { [weak self] failure in
            if failure {
                // show alert with error
            }
        }
    }
    
    private func showAlertNoItems() {
        let message = "No se encontraron resultados con esta busqueda, prueba con otro nombre."
        let alertController = UIAlertController(title: "Busqueda", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.itemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        guard let viewModel = viewModel else { return cell }
        let meal = viewModel.item(at: indexPath.row)
        cell.configure(with: meal)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searchBar.endEditing(true)
        viewModel?.searchMeals(searchText)
    }
}
