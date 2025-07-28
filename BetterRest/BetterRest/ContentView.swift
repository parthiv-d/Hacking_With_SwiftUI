//
//  ContentView.swift
//  BetterRest
//
//  Created by T0204ZL on 26/07/25.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 0
    
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading, spacing: 10) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Desired amount of sleep:")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                        .padding()
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text("Daily coffee intake:")
                        .font(.headline)
                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 0...40)
                        .padding()
                }
            }
            .navigationTitle("BetterRest")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Calculate", action: calculateBedtime)
                }
            }
            .alert(alertTitle, isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
//            .alert(isPresented: $showAlert) {
//                Alert(title: Text(alertTitle ?? ""), message: Text(alertMessage ?? ""))
//            }
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is:"
            alertMessage = "\(sleepTime.formatted(date: .omitted, time: .shortened))"
            
        } catch {
            alertTitle = "Error"
            alertMessage = error.localizedDescription
        }
        showAlert = true
    }
}

#Preview {
    ContentView()
}
