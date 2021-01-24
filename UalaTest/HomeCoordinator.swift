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

extension HomeCoordinator {
    func goToMealDetail(_ mealId: String) {
        guard let mealViewController = storyboard.instantiateViewController(identifier: "MealViewController") as? MealViewController else { return }
        let mealService = MealServices()
        let viewModel = MealViewModel(mealService: mealService)
        mealViewController.viewModel = viewModel
        mealViewController.coordinator = self
        mealViewController.mealId = mealId
        navigationController.pushViewController(mealViewController, animated: true)
    }
    
    func popController() {
        navigationController.popViewController(animated: true)
    }
}
