//
//  SessionManager.swift
//  EnvironmentObjectTraining
//
//  Created by T0204ZL on 18/07/25.
//

import Foundation
import Combine
import SwiftUI
import LocalAuthentication

class SessionManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var username: String = ""
    
    private let userKey = "savedUsername"
    
    init() {
        // Auto-login if credentials exist
        if let savedUser = UserDefaults.standard.string(forKey: userKey) {
            self.username = savedUser
            self.isLoggedIn = true
        }
    }
    
    func login(user: String) {
        self.username = user
        self.isLoggedIn = true
        UserDefaults.standard.set(user, forKey: userKey)
    }
    
    func logout() {
        self.username = ""
        self.isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: userKey)
    }
}

