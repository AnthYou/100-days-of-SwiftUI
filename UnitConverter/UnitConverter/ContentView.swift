//
//  ContentView.swift
//  UnitConverter
//
//  Created by Anthony You on 01/03/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedInputUnit = 0
    @State private var selectedOutputUnit = 1
    @State private var inputValue = ""
    
    let unitTypes: [String] = ["meters", "kilometers", "feets", "yards", "miles"]
    
    var computedValue: Double {
        let rawValue = Double(inputValue) ?? 0
        var valueMeters: Double
        var convertedValue: Double
        
        switch selectedInputUnit {
        case 0:
            valueMeters = rawValue
        case 1:
            valueMeters = rawValue * 1_000
        case 2:
            valueMeters = rawValue / 3.28084
        case 3:
            valueMeters = rawValue / 1.09361
        case 4:
            valueMeters = rawValue * 1_609
        default:
            valueMeters = rawValue
        }
        
        switch selectedOutputUnit {
        case 0:
            convertedValue = valueMeters
        case 1:
            convertedValue = valueMeters / 1_000
        case 2:
            convertedValue = valueMeters * 3.28084
        case 3:
            convertedValue = valueMeters * 1.09361
        case 4:
            convertedValue = valueMeters / 1_609
        default:
            convertedValue = rawValue
        }
        
        return convertedValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    TextField("Value to convert", text: $inputValue)
                        .keyboardType(.decimalPad)
                    Picker("Input unit", selection: $selectedInputUnit) {
                        ForEach(0 ..< unitTypes.count) {
                            Text(unitTypes[$0])
                        }
                    }
                    Picker("Output unit", selection: $selectedOutputUnit) {
                        ForEach(0 ..< unitTypes.count) {
                            Text(unitTypes[$0])
                        }
                    }
                }
                Section(header: Text("Result")) {
                    Text("\(computedValue, specifier: "%.2f") \(unitTypes[selectedOutputUnit])")
                }
            }
            .navigationBarTitle("UnitConverter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
