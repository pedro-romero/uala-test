//
//  MealViewController.swift
//  UalaTest
//
//  Created by Pedro Iván Romero Ojeda on 1/23/21.
//  Copyright © 2021 piro. All rights reserved.
//

import UIKit
import Kingfisher

class MealViewController: UIViewController {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var ingredientsStackView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: MealViewModel?
    weak var coordinator: HomeCoordinator?
    var mealId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        guard let mealId = mealId else { return }
        viewModel?.fetch(byId: mealId)
    }
    
    private func bindViewModel() {
        viewModel?.updateMeal = { [weak self] meal in
            guard let meal = meal else { return }
            self?.updateMeal(meal)
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
    
    private func updateMeal(_ meal: Meal) {
        thumbnailImageView.image = nil
        if let thumbUrl = URL(string: meal.strMealThumb) {
            thumbnailImageView.kf.setImage(with: thumbUrl)
        }
        titleLabel.text = meal.strMeal
        instructionsLabel.text = meal.strInstructions
        for ingredient in meal.getIngredientes() {
            let label = UILabel()
            label.text = ingredient
            ingredientsStackView.addArrangedSubview(label)
        }
    }
}
