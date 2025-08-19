//
//  CocktailDataManager.swift
//  CocktailsDB
//
//  Created by T0204ZL on 13/08/25.
//

import Foundation
import Combine

class CocktailServiceDataManager {
    static let shared = CocktailServiceDataManager()
    private init() {}

    func fetchDrinks<T: Decodable>(startingWith letter: String, type: T.Type) -> AnyPublisher<T, Error> {
        let baseURL = "https://thecocktaildb.com/api/json/v1/1/search.php?f="
        guard let url = URL(string: baseURL + letter) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
