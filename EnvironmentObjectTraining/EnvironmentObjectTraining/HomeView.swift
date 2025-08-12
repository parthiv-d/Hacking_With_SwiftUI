//
//  HomeView.swift
//  EnvironmentObjectTraining
//
//  Created by T0204ZL on 18/07/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionManager

    @Namespace private var animation
    @State private var isExpanded = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome, \(session.username)")
                    .font(.title)
                    .padding()
                
                    
                
                VStack {
                    if !isExpanded {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.blue)
                            .matchedGeometryEffect(id: "box", in: animation)
                            .frame(width: 100, height: 100)
                    }
                    
                    Spacer()
                    
                    if isExpanded {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.red)
                            .matchedGeometryEffect(id: "box", in: animation)
                            .frame(width: 300, height: 300)
                    }
                    
                    Button("Toggle") {
                        withAnimation(.snappy) {
                            isExpanded.toggle()
                        }
                    }
                }
                .padding()
                
                
                Button("Logout") {
                    session.logout()
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") {
                        // Handle back action
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Settings") {
                        // Handle settings action
                    }
                }
                
            }
        }
    }
}

#Preview {
    HomeView()
}
