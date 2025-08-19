//
//  InitialView.swift
//  CocktailsDB
//
//  Created by T0204ZL on 13/08/25.
//

import SwiftUI

struct InitialView: View {
    @StateObject var viewModel = InitialViewModel()
    
    @State private var path: [Int] = [] // Navigation path
    
    var body: some View {
        NavigationStack(path: $path) {
            List(viewModel.initialViewItems.indices, id: \.self) { index in
                        Button {
                            handleNavigation(for: index)
                        } label: {
                            HCard(section: viewModel.initialViewItems[index])
                        }
                        .buttonStyle(PlainButtonStyle())
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            
            .navigationTitle("The Cocktails DB")
            .navigationDestination(for: Int.self) { index in
                            destinationView(for: index)
                        }
        }
        .onAppear() {
            viewModel.fetchInitialViewItems()
        }
        
    }
    
    // MARK: - Navigation Handling
       private func handleNavigation(for index: Int) {
           path.append(index)
       }
    @ViewBuilder
        private func destinationView(for index: Int) -> some View {
            switch index {
            case 0:
                AlphabetView()
            default:
                Text("Default Screen")
            }
        }
}

#Preview {
    InitialView()
}
