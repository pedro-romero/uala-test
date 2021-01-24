//
//  MealService.swift
//  UalaTest
//
//  Created by Pedro Iván Romero Ojeda on 1/23/21.
//  Copyright © 2021 piro. All rights reserved.
//

import Foundation
import Alamofire

class MealServices {
    private enum MealServiceRouter: ServiceBase {
        case search(searchText: String)
        case byId(mealId: String)
        
        var baseURL: URL {
            URL(string: "https://www.themealdb.com")!
        }
        
        var method: HTTPMethod {
            switch self {
            case .search, .byId:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .search:
                return "api/json/v1/1/search.php"
            case .byId:
                return "api/json/v1/1/lookup.php"
            }
        }
        
        var encoding: ParameterEncoding {
            switch self {
            case .search, .byId:
                return URLEncoding.default
            }
        }
        
        var parameters: Parameters? {
            switch self {
            case let .search(searchText):
                return ["s": searchText]
            case let .byId(mealId):
                return ["i": mealId]
            }
        }
        
        func asURLRequest() throws -> URLRequest {
            let url = baseURL.appendingPathComponent(path)
            var request = URLRequest(url: url)
            request.method = method
            request = try encoding.encode(request, with: parameters)
            return request
        }
    }
    
    func search(_ searchText: String, completion: @escaping (Result<[Meal], Error>) -> Void) {
        MealServiceRouter.search(searchText: searchText).fetchDecodable { (response: (Result<MealsResponse, Error>)) in
            switch response {
            case let .success(mealResponse):
                completion(.success(mealResponse.meals ?? []))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func byId(_ mealId: String, completion: @escaping (Result<Meal?, Error>) -> Void) -> Void {
        MealServiceRouter.byId(mealId: mealId).fetchDecodable { (response: (Result<MealsResponse, Error>)) in
            switch response {
            case let .success(mealsResponse):
                guard let meals = mealsResponse.meals else {
                    completion(.success(nil))
                    return
                }
                completion(.success(meals.first))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
