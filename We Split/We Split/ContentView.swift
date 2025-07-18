//
//  ContentView.swift
//  We Split
//
//  Created by T0204ZL on 04/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var amount: Double = 0
    @State private var numberOfPeople: Int = 2
    private var tipPercentages = [10, 15, 20, 25, 0]
    
    @State private var selectedTipPercentage: Int = 10
    @FocusState private var isTextFieldFocused: Bool
    
    var perPersonAmount: Double {
        let tipValue = amount * Double(selectedTipPercentage) / 100
        let totalAmount = amount + tipValue
        return totalAmount / Double(numberOfPeople)
    }
    
    var totalAmount: Double {
        let tipValue = amount * Double(selectedTipPercentage) / 100
        return amount + tipValue
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Check Amount") {
                    TextField("Check Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                        .font(.title)
                        .keyboardType(.decimalPad)
                        .focused($isTextFieldFocused)
                    
                    Picker("Number Of People", selection: $numberOfPeople) {
                        ForEach(1...20, id: \.self) {
                            Text("\($0) People")
                                .tag($0)
                        }
                    }
                    .pickerStyle(.automatic)
                }
                
                Section {
                    Text("How much tip do you want to leave?")
                    
                    Picker("Tip Percentage", selection: $selectedTipPercentage) {
                        ForEach(tipPercentages, id: \.self) { percentage in
                            Text("\(percentage)%")
                                .tag(percentage)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Total Amount")) {
                    Text(totalAmount, format: .currency(code: "INR"))
                }
                
                Section(header: Text("Amount Per Person")) {
                    Text(perPersonAmount, format: .currency(code: "INR"))
                        .font(.title)
                        .foregroundColor(perPersonAmount == 0 ? .blue : .green)
                }
            }
            .navigationTitle("We Split")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                if isTextFieldFocused {
                    ToolbarItem() {
                        Button("Done") {
                            
                            isTextFieldFocused = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
