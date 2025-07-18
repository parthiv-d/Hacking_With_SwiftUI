//
//  RootView.swift
//  EnvironmentObjectTraining
//
//  Created by T0204ZL on 18/07/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var session: SessionManager

    var body: some View {
        Group {
            if session.isLoggedIn {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    RootView()
}
