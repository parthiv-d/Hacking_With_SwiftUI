//
//  DrinkListViewModel.swift
//  CocktailsDB
//
//  Created by T0204ZL on 13/08/25.
//

import Foundation

import Combine

class DrinkListViewModel: ObservableObject {
    @Published var drinks: [Drink] = []
    @Published var selectedDrink: Drink?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchDrinks(letter: String) {
        CocktailServiceDataManager.shared.fetchDrinks(startingWith: letter, type: DrinkResponse.self)
            .map { $0.drinks }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Successfully fetched drinks")
                    break // Handle success
                case .failure(let error):
                    print("Error fetching drinks: \(error)")
                }
            }, receiveValue: { [weak self] drinks in
                self?.drinks = drinks
            })
            .store(in: &cancellables)
        
    }
    
}
