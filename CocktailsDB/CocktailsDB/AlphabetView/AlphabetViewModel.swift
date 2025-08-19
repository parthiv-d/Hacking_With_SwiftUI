//
//  AlphabetViewModel.swift
//  CocktailsDB
//
//  Created by T0204ZL on 13/08/25.
//

import Foundation

class AlphabetViewModel: ObservableObject {
    @Published var letters: [String] = []
    
    
    func generateAlphabetAndNumbers() {
        // Generate letters A-Z
        let alphabet = (65...90).map { String(UnicodeScalar($0)!) }
        
        // Generate numbers 0-9
        let numbers = (0...9).map { String($0) }
        
        // Combine and sort
        letters = (alphabet + numbers)
    }

        
}
