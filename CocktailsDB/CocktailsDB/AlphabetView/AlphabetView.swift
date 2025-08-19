//
//  AlphabetView.swift
//  CocktailsDB
//
//  Created by T0204ZL on 13/08/25.
//

import SwiftUI

struct AlphabetView: View {
    
    @StateObject private var viewModel = AlphabetViewModel()
    
    var body: some View {
        ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(chunked(viewModel.letters, size: 2), id: \.self) { row in
                            HStack(spacing: 12) {
                                ForEach(row, id: \.self) { letter in
                                    NavigationLink(destination: DrinkListView(letter: letter)) {
                                                                GCard(title: letter)
                                            .foregroundColor(.secondary)
                                                            }
                                                            .buttonStyle(PlainButtonStyle())
                                }
                                // Fill empty space if odd count
                                if row.count == 1 {
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding()
                }
        .onAppear() {
            viewModel.generateAlphabetAndNumbers()
        }
    }
    
    private func chunked<T>(_ array: [T], size: Int) -> [[T]] {
        stride(from: 0, to: array.count, by: size).map {
            Array(array[$0 ..< min($0 + size, array.count)])
        }
    }
        
}

#Preview {
    AlphabetView()
}
