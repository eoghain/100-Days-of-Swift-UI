//
//  ContentView.swift
//  100Days_Challenge1
//
//  Created by Robert Booth on 2/4/20.
//  Copyright © 2020 Robert Booth. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    let unitTypes = ["Temp", "Length", "Time", "Volume"]
    let tempUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    let tempConversions = [
        "Celsius" : UnitTemperature.celsius,
        "Fahrenheit": UnitTemperature.fahrenheit,
        "Kelvin": UnitTemperature.kelvin
    ]

    let lengthUnits = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    let lengthConversions = [
        "Meters": UnitLength.meters,
        "Kilometers": UnitLength.kilometers,
        "Feet": UnitLength.feet,
        "Yards": UnitLength.yards,
        "Miles": UnitLength.miles
    ]

    let timeUnits = ["Seconds", "Minutes", "Hours"]
    let timeConversions = [
        "Seconds": UnitDuration.seconds,
        "Minutes": UnitDuration.minutes,
        "Hours": UnitDuration.hours
    ]

    let volumeUnits = ["Milliliters", "Liters", "Cups", "Pints", "Gallons"]
    let volumeConversions = [
        "Milliliters": UnitVolume.milliliters,
        "Liters": UnitVolume.liters,
        "Cups": UnitVolume.cups,
        "Pints": UnitVolume.pints,
        "Gallons": UnitVolume.gallons
    ]

    @State var conversionType: Int = 0
    @State var fromUnit: Int = 0
    @State var toUnit: Int = 0
    @State var value: String = "0"

    var fromUnitKey: String {
        get {
            switch conversionType {
            case 0: return tempUnits[fromUnit]
            case 1: return lengthUnits[fromUnit]
            case 2: return timeUnits[fromUnit]
            case 3: return volumeUnits[fromUnit]
            default: return "Missing"
            }
        }
    }

    var toUnitKey: String {
        get {
            switch conversionType {
            case 0: return tempUnits[toUnit]
            case 1: return lengthUnits[toUnit]
            case 2: return timeUnits[toUnit]
            case 3: return volumeUnits[toUnit]
            default: return "Missing"
            }
        }
    }

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
                Section(header: Text("Conversion Type")) {
                    UnitPicker(title: "Units", units: unitTypes, selected: $conversionType)
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Conversion")) {
                    TextField("Value", text: $value)
                        .keyboardType(.decimalPad)
                    UnitPicker(title: "From", units: getUnits(), selected: $fromUnit)
                    UnitPicker(title: "To", units: getUnits(), selected: $toUnit)
                }
                .pickerStyle(SegmentedPickerStyle())

                Section(header: Text("Results")) {
                    calculateConversion()
                }
            }
            .navigationBarTitle("Unit Conversion")
        }
    }

    func getUnits() -> [String] {
        switch conversionType {
        case 0: return tempUnits
        case 1: return lengthUnits
        case 2: return timeUnits
        case 3: return volumeUnits
        default: return []
        }
    }

    func calculateConversion() -> some View {
        guard let value = Double(value) else {
            return Text("Decimal values only!")
        }

        var conversionsDict: [String: Dimension]?
        switch conversionType {
        case 0: conversionsDict = tempConversions
        case 1: conversionsDict = lengthConversions
        case 2: conversionsDict = timeConversions
        case 3: conversionsDict = volumeConversions
        default: break
        }

        guard
            let conversions = conversionsDict,
            let fromUnits = conversions[fromUnitKey],
            let toUnits = conversions[toUnitKey]
        else {
            return Text("Invalid units!")
        }

        let measurement = Measurement(value: value, unit: fromUnits)
        let conversion = measurement.converted(to: toUnits)

        let formatter = MeasurementFormatter()
        formatter.numberFormatter = decimalFormatter
        formatter.unitOptions = .providedUnit

        return Text("\(formatter.string(from: conversion))")
    }
}

struct UnitPicker: View {
    let title: String
    let units: [String]
    var selected: Binding<Int>

    var body: some View {
        Picker(title, selection: selected) {
            ForEach(0..<units.count, id: \.self) {
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
