//
//  HomeCoordinator.swift
//  UalaTest
//
//  Created by Pedro Iván Romero Ojeda on 1/23/21.
//  Copyright © 2021 piro. All rights reserved.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let storyboard = UIStoryboard(name: "Home", bundle: nil)
    
    // MARK: - VM / VC's
    
    lazy var homeViewController: HomeViewController? = {
        let homeViewController = storyboard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController
        let mealService = MealServices()
        let viewModel = HomeViewModel(mealService: mealService)
        homeViewController?.viewModel = viewModel
        homeViewController?.coordinator = self
        return homeViewController
    }()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        guard let homeViewController = homeViewController else { return }
//        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: false)
    }
    
    override func finish() {}
}
