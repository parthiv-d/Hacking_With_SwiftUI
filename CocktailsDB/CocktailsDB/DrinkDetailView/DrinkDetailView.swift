//
//  DrinkDetailView.swift
//  CocktailsDB
//
//  Created by T0204ZL on 18/08/25.
//

import SwiftUI

struct DrinkDetailView: View {
    @ObservedObject var viewModel: DrinkListViewModel
    var body: some View {
        ScrollView {
            VCard(drink: viewModel.selectedDrink,
                  onAlternate: { value in print("Alternate: \(value)") },
                  onTags: { value in print("Tags: \(value)") },
                  onVideo: { value in print("Video: \(value)") },
                  onCategory: { value in print("Category: \(value)") },
                  onIBA: { value in print("IBA: \(value)") },
                  onAlcoholic: { value in print("Alcoholic: \(value)") },
                  onGlass: { value in print("Glass: \(value)") },
                  onIngredient: { ingredient, measure in print("Ingredient: \(ingredient), Measure: \(measure)") }
              )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
        }
        .navigationTitle("\(viewModel.selectedDrink?.strDrink)")
    }
}

#Preview {
//    DrinkDetailView()
}
