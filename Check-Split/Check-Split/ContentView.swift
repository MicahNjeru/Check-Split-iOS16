//
//  ContentView.swift
//  Check-Split
//
//  Created by Micah Jesse Njeru on 22/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    // Constant List of available tipPercentage
    let tipPercentages = [10, 15, 20, 25, 0]
    
    // Computed Property for calculating the tip
    var totalPerPerson: Double {
        // Create new constant and convert data type of numberOfPeopl to Double
        let peopleCount = Double(numberOfPeople + 2)
        
        // Create new constant and convert data type of tipPercentage to Double
        let tipSelection = Double(tipPercentage)
        
        // Math logic for calculating the amount per person goes here
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            
            Form {
                
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "Sh."))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to give?")
                }
                
                Section {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "Sh."))
                } header: {
                    Text("Total to pay per person.")
                }
            }
            .navigationTitle("Check-Split")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
