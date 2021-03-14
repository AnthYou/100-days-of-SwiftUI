//
//  ContentView.swift
//  BetterRest
//
//  Created by Anthony You on 03/03/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
        
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Recommended bed time")
                    Text(calculateBedtime)
                        .font(.largeTitle)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                    .accessibility(value: Text("\(sleepAmount) hours of sleep"))
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    Picker("Number of cups", selection: $coffeeAmount) {
                        ForEach(0...20, id: \.self) { number in
                            if number == 1 {
                                Text("1 cup")
                            } else {
                                Text("\(number) cups")
                            }
                        }
                    }
//                    Stepper(value: $coffeeAmount, in: 1...20) {
//                        if coffeeAmount == 1 {
//                            Text("1 cup")
//                        } else {
//                            Text("\(coffeeAmount) cups")
//                        }
//                    }
                }
            }
            .navigationBarTitle("BetterRest")
//            .navigationBarItems(trailing:
//                Button(action: calculateBedtime) {
//                    Text("Calculate")
//                }
//            )
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            })
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    // changed from function to var to display in real time the result
    var calculateBedtime: String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let model: SleepCalculator = try SleepCalculator(configuration: .init())
            let predication = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - predication.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
//            alertMessage = formatter.string(from: sleepTime)
//            alertTitle = "Your ideal bedtime is..."
        } catch {
            return "Error"
//            alertTitle = "Error"
//            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
//        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
