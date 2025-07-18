//
//  ContentView.swift
//  Guess The Flag
//
//  Created by T0204ZL on 04/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
    ZStack() {
            
            Color.black
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
