//
//  DrinkListView.swift
//  CocktailsDB
//
//  Created by T0204ZL on 13/08/25.
//

import SwiftUI

struct DrinkListView: View {
    let letter: String
    @StateObject private var viewModel = DrinkListViewModel()
    
    var body: some View {
        List(viewModel.drinks) { drink in
            NavigationLink(destination: DrinkDetailView(viewModel: viewModel)
                .onAppear{
                    print("Selected drink: \(drink.strDrink)")
                    viewModel.selectedDrink = drink
                }
            ) {
                DrinkCard(section: drink)
                    .foregroundColor(.secondary)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)

            .onAppear {
                viewModel.fetchDrinks(letter: letter)
            }
    }
        
}

#Preview {
    DrinkListView(letter: "a")
}
