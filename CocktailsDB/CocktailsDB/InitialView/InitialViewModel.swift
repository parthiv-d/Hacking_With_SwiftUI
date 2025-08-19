//
//  InitialViewModel.swift
//  CocktailsDB
//
//  Created by T0204ZL on 13/08/25.
//

import Foundation
import SwiftUICore


class InitialViewModel: ObservableObject {
    @Published var initialViewItems: [InitialModel] = []
    
    func fetchInitialViewItems() {
        initialViewItems.append(InitialModel(title: "By Alphabhetically", caption: "View Cocktails List Based On Alphabhet", color: Color(hex: "6792FF")))
//        initialViewItems.append(InitialModel(title: "By Alphabhetically", caption: "View Cocktails List Based On Alphabhet", color: Color(hex: "6752FF")))
        /*
         Need to add One More section to show
         www.thecocktaildb.com/api/json/v1/1/list.php?c=list
         www.thecocktaildb.com/api/json/v1/1/list.php?g=list
         www.thecocktaildb.com/api/json/v1/1/list.php?i=list
         www.thecocktaildb.com/api/json/v1/1/list.php?a=list
         these details and subsequent views
         */
        
//        Show Random Cocktail www.thecocktaildb.com/api/json/v1/1/random.php
        
        
    }
    
}
