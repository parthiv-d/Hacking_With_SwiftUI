//
//  LoginView.swift
//  EnvironmentObjectTraining
//
//  Created by T0204ZL on 18/07/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var session: SessionManager
    @State private var inputUsername = ""

    var body: some View {
        VStack {
            TextField("Enter Username", text: $inputUsername)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Login") {
                session.login(user: inputUsername)
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
