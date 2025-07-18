//
//  EnvironmentObjectTrainingApp.swift
//  EnvironmentObjectTraining
//
//  Created by T0204ZL on 18/07/25.
//

import SwiftUI

@main
struct EnvironmentObjectTrainingApp: App {
    @StateObject private var session = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(session)
        }
    }
}
