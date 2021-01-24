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
        
        var baseURL: URL {
            URL(string: "https://www.themealdb.com")!
        }
        
        var method: HTTPMethod {
            switch self {
            case .search:
                return .get
            }
        }
        
        var path: String {
            switch self {
            case .search:
                return "api/json/v1/1/search.php"
            }
        }
        
        var encoding: ParameterEncoding {
            switch self {
            case .search:
                return URLEncoding.default
            }
        }
        
        var parameters: Parameters? {
            switch self {
            case let .search(searchText):
                return ["s": searchText]
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
                completion(.success(mealResponse.meals))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
