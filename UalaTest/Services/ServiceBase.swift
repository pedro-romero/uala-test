//
//  ServiceBase.swift
//  UalaTest
//
//  Created by Pedro Iván Romero Ojeda on 1/23/21.
//  Copyright © 2021 piro. All rights reserved.
//

import Foundation
import Alamofire

protocol ServiceBase: URLRequestConvertible {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var encoding: ParameterEncoding { get }
    var parameters: Parameters? { get }
}

extension ServiceBase {
    func fetchDecodable<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(self)
            .validate()
            .responseDecodable(of: T.self) { (response) in
                switch response.result {
                case let .success(decodeObject):
                    completion(.success(decodeObject))
                case let .failure(error):
                    completion(.failure(error))
                }
        }
    }
}
