//
//  HomeViewModel.swift
//  UalaTest
//
//  Created by Pedro Iván Romero Ojeda on 1/23/21.
//  Copyright © 2021 piro. All rights reserved.
//

import Foundation

class HomeViewModel {
    private let mealService: MealServices
    private var meals: [Meal] = []
    
    var updateMeals: (() -> Void)?
    var isLoading: ((Bool) -> Void)?
    var isError: ((Bool) -> Void)?
    
    init(mealService: MealServices) {
        self.mealService = mealService
    }
    
    func itemsCount() -> Int {
        return meals.count
    }
    
    func item(at index: Int) -> Meal {
        return meals[index]
    }
    
    func searchMeals(_ searchText: String) {
        isLoading?(true)
        mealService.search(searchText) { [weak self] result in
            self?.isLoading?(false)
            switch result {
            case let .success(meals):
                self?.meals = meals
                self?.updateMeals?()
            case let .failure(error):
                print(error)
                self?.isError?(true)
            }
        }
    }
}
