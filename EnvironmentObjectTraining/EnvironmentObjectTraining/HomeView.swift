//
//  HomeView.swift
//  EnvironmentObjectTraining
//
//  Created by T0204ZL on 18/07/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var session: SessionManager

    var body: some View {
        VStack {
            Text("Welcome, \(session.username)")
                .font(.title)
                .padding()

            Button("Logout") {
                session.logout()
            }
        }
    }
}

#Preview {
    HomeView()
}
