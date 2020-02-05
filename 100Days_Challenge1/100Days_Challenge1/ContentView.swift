//
//  ContentView.swift
//  100Days_Challenge1
//
//  Created by Robert Booth on 2/4/20.
//  Copyright © 2020 Robert Booth. All rights reserved.
//

import SwiftUI

struct ContentView: View {

//    let unitTypes = ["Temp", "Length"]
    let tempUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    let lengthUnits = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]

//    @State var conversionType: Int = 0
    @State var fromUnit: Int = 0
    @State var toUnit: Int = 0
    @State var value: String = "0"

    var units = ["Celsius", "Fahrenheit", "Kelvin"]
//    var units:[String] {
//        get {
//            switch conversionType {
//            case 0: return tempUnits
//            case 1: return lengthUnits
//            default: return ["Unknown"]
//            }
//        }
//    }

    private let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2

        return formatter
    }()

    var body: some View {
        NavigationView {
            Form {
//                Section(header: Text("Conversion Type")) {
//                    UnitPicker(title: "Units", units: unitTypes, selected: $conversionType)
//                    .pickerStyle(SegmentedPickerStyle())
//                }
                Section(header: Text("Conversion")) {
                    TextField("Value", text: $value)
                        .keyboardType(.decimalPad)
                    UnitPicker(title: "From", units: units, selected: $fromUnit)
                    UnitPicker(title: "To", units: units, selected: $toUnit)
                }
                .pickerStyle(SegmentedPickerStyle())

                Section(header: Text("Results")) {
                    calculateConversion()
                }
            }
            .navigationBarTitle("Unit Conversion")
        }
    }

    func calculateConversion() -> some View {

        return Text("\(tempConversion())")
    }

    func tempConversion() -> String {
        guard Double(value) != nil else { return "Decimal values only" }
        switch (fromUnit, toUnit) {
        case (0,0): return "\(value)°C"
        case (0,1): return "\(format(celsiusToFarenheit()))°F"
        case (0,2): return "\(format(celsiusToKelvin()))K"

        case (1,0): return "\(format(farenheitToCelsius()))°C"
        case (1,1): return "\(value)°F"
        case (1,2): return "\(format(farenheitToKelvin()))K"

        case (2,0): return "\(format(kelvinToCelsius()))°C"
        case (2,1): return "\(format(kelvinToFarenheit()))°F"
        case (2,2): return "\(value)K"

        default: return "What did you do?  I don't know!"
        }
    }

    func format(_ value: Double) -> String {
        return decimalFormatter.string(from: NSNumber(value: value)) ?? "???"
    }

    func celsiusToFarenheit() -> Double {
        // (0°C × 9/5) + 32 = 32°F
        guard let value = Double(value) else { return 0 }
        return (value * (9/5)) + 32
    }

    func celsiusToKelvin() -> Double {
        // 0°C + 273.15 = 273.15K
        guard let value = Double(value) else { return 0 }
        return value + 273.15
    }

    func farenheitToCelsius() -> Double {
        // (0°F − 32) × 5/9 = -17.78°C
        guard let value = Double(value) else { return 0 }
        return (value - 32) * (5/9)
    }

    func farenheitToKelvin() -> Double {
        // (0°F − 32) × 5/9 + 273.15 = 255.372K
        guard let value = Double(value) else { return 0 }
        return (value - 32) * (5/9) + 273.15
    }

    func kelvinToCelsius() -> Double {
        // 0K − 273.15 = -273.1°C
        guard let value = Double(value) else { return 0 }
        return value - 273.15
    }

    func kelvinToFarenheit() -> Double {
        // (0K − 273.15) × 9/5 + 32 = -459.7°F
        guard let value = Double(value) else { return 0 }
        return (value - 273.15) * (9/5) + 32
    }
}

struct UnitPicker: View {
    let title: String
    let units: [String]
    var selected: Binding<Int>

    var body: some View {
        Picker(title, selection: selected) {
            ForEach(0..<units.count) {
                Text("\(self.units[$0])")
            }
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
