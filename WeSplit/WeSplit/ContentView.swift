//
//  ContentView.swift
//  WeSplit
//
//  Created by Robert Booth on 2/11/20.
//  Copyright © 2020 Robert Booth. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2

    let tipPercentages = [10, 15, 20, 25, 0]

    var tipValue : Double {
        return Double(tipPercentages[tipPercentage])
    }

    var grandTotal: Double {
        let orderAmount = Double(checkAmount) ?? 0
        let tipTotal = orderAmount / 100 * tipValue
        return orderAmount + tipTotal
    }

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 1
        return grandTotal / peopleCount
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)

                    TextField("Number of people", text: $numberOfPeople)
                }

                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Total Amount")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                        .zeroTipStyle(tipPercent: tipValue)
                }

                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ZeroTip: ViewModifier {
    let tipPercent: Double

    func body(content: Content) -> some View {
        content
            .foregroundColor(tipPercent > 0 ? .black : .red)
    }
}

extension View {
    func zeroTipStyle(tipPercent: Double) -> some View {
        return self.modifier(ZeroTip(tipPercent: tipPercent))
    }
}


// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
