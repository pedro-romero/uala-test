//
//  MealViewModel.swift
//  UalaTest
//
//  Created by Pedro Iván Romero Ojeda on 1/23/21.
//  Copyright © 2021 piro. All rights reserved.
//

import Foundation

class MealViewModel {
    private let mealService: MealServices
    private var meal: Meal?
    
    var updateMeal: ((Meal?) -> Void)?
    var isLoading: ((Bool) -> Void)?
    var isError: ((Bool) -> Void)?
    
    init(mealService: MealServices) {
        self.mealService = mealService
    }
    
    func fetch(byId mealId: String) {
        isLoading?(true)
        mealService.byId(mealId) { [weak self] result in
            self?.isLoading?(false)
            switch result {
            case let .success(meal):
                self?.meal = meal
                self?.updateMeal?(meal)
            case let .failure(error):
                print(error)
                self?.isError?(true)
            }
        }
    }
}
