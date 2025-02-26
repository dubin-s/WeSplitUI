//
//  ContentView.swift
//  WeSplitUI
//
//  Created by Spenser Dubin on 2/22/25.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    struct Bill {
        let amountPerPerson: Double
        let grandTotal: Double
    }
    
    var bill: Bill {
        let peopleCount = Double(numberOfPeople + 2)
        let tipPerc = Double(tipPercentage)
        let tipAmount = checkAmount * (tipPerc / 100)
        let grandTotal = checkAmount + tipAmount
        let amountPerPerson = grandTotal / peopleCount
        return Bill(amountPerPerson: amountPerPerson, grandTotal: grandTotal)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Check details") {
                    TextField("Check amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("Tip percentage") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total check amount") {
                    Text(bill.grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount per person") {
                    Text(bill.amountPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
