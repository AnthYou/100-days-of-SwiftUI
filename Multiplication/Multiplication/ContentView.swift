//
//  ContentView.swift
//  Multiplication
//
//  Created by Anthony You on 04/03/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    @State private var tableUpTo = 1
    @State private var numberOfQuestions = "5"
    @State private var questionsList = [Question]()
    @State private var currentQuestionIndex = 0
    @State private var userAnswer = ""
    @State private var score = 0
    @State private var isShowingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var dismissButton = ""

    let possibleNumberOfQuestions: [String] = ["5", "10", "20", "all"]
    
    var round: Int {
        return currentQuestionIndex + 1
    }
    
    var body: some View {
        NavigationView {
            Group {
                if isActive {
                    VStack {
                        Text(questionsList[currentQuestionIndex].text)
                            .font(.largeTitle)
                        Form {
                            TextField("Answer", text: $userAnswer)
                                .keyboardType(.numberPad)
                            Button("Submit") {
                                sendAnswer()
                            }
                        }
                        Spacer()
                        Text("Score: \(score)")
                        
                    }
                    .navigationBarItems(leading: Button(action: {
                        withAnimation {
                            self.isActive = false
                        }
                    }, label: {
                        Image(systemName: "gobackward")
                        Text("New")
                    }), trailing: Text("Question: \(round)/\(questionsList.count)"))
                } else {
                    VStack {
                        Form {
                            Section(header: Text("Tables up to...")) {
                                Stepper(value: $tableUpTo, in: 1...12) {
                                    Text("\(tableUpTo)")
                                }
                            }
                            Section(header: Text("Number of questions")) {
                                Picker("Number of questions", selection: $numberOfQuestions) {
                                    ForEach(possibleNumberOfQuestions, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                        }
                        Button(action: {
                            generateQuestions(tablesUpTo: tableUpTo, numberOfQuestions: numberOfQuestions)
                            self.isActive = true
                        }, label: {
                            Text("Start now")
                                .font(.largeTitle)
                        })
                    }
                }
            }
            .navigationTitle("Multiplication")
            .alert(isPresented: $isShowingAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text(dismissButton)))
            })
        }
    }
    
    func generateQuestions(tablesUpTo: Int, numberOfQuestions: String) {
        var tempList = [Question]()
        
        for i in 1...tablesUpTo {
            for j in 1...12 {
                if j >= i {
                    let result = String(i * j)
                    tempList.append(Question(text: "\(i) x \(j)?", answer: result))
                    if i != j {
                        tempList.append(Question(text: "\(j) x \(i)?", answer: result))
                    }
                }
            }
        }
        
        if numberOfQuestions == "all" {
            questionsList = tempList.shuffled()
        } else {
            questionsList = Array(tempList.shuffled()[0 ..< Int(numberOfQuestions)!])
        }
    }
    
    func sendAnswer() {
        if userAnswer == questionsList[currentQuestionIndex].answer {
            score += 1
            alertTitle = "Good job! 👏"
            alertMessage = "Your score is \(score)."
            userAnswer = ""
        } else {
            alertTitle = "Wrong! 👎"
            alertMessage = "Your score is \(score)."
            userAnswer = ""
        }
        if round < questionsList.count {
            currentQuestionIndex += 1
            dismissButton = "Next"
        } else {
            dismissButton = "End"
            isActive = false
        }
        isShowingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
