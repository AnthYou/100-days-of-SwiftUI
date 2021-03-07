//
//  ContentView.swift
//  Shifumi
//
//  Created by Anthony You on 02/03/2021.
//

import SwiftUI

struct Move: View {
    let name: String
    var isSelected: Bool
    
    var body: some View {
        Image(name)
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .opacity(isSelected ? 1 : 0.5)
    }
}

struct ContentView: View {
    let moves: [String] = ["Rock", "Paper", "Scissors"]
    
    @State private var appChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var playerChoice = 0
    
    @State private var score = 0
    @State private var roundNumber = 1
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertBody = ""
    
    @State private var gameHasEnded = false
    
    private func computeScore() {
        switch appChoice {
        case 0:
            if (playerChoice == 1 && shouldWin) || (playerChoice != 1 && !shouldWin) {
                answerIsRight()
            } else {
                answerIsWrong()
            }
        case 1:
            if (playerChoice == 2 && shouldWin) || (playerChoice != 2 && !shouldWin) {
                answerIsRight()
            } else {
                answerIsWrong()
            }
        case 2:
            if (playerChoice == 0 && shouldWin) || (playerChoice != 0 && !shouldWin) {
                answerIsRight()
            } else {
                answerIsWrong()
            }
        default:
            print("An error has occured")
        }
        
        if roundNumber == 10 {
            restartGame()
        } else {
            nextRound()
        }
    }
    
    private func nextRound() {
        roundNumber += 1
        appChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }
    
    private func restartGame() {
        showAlert = true
        alertTitle = "Game over! 🚦"
        alertBody = "Your score is \(score)/10."
        gameHasEnded = true
        roundNumber = 1
        score = 0
        appChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
        gameHasEnded = false
    }
    
    private func answerIsRight() {
        score += 1
        showAlert = true
        alertTitle = "Well done! 👏"
        alertBody = "\(moves[playerChoice]) over \(moves[appChoice]) \(shouldWin ? "wins" : "lose"). Your score is \(score)."
    }
    
    private func answerIsWrong() {
        score -= 1
        showAlert = true
        alertTitle = "Wrong! 👎"
        alertBody = "\(moves[playerChoice]) over \(moves[appChoice]) \(shouldWin ? "lose" : "win"). Your score is \(score)."
    }
        
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.pink, .blue]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Opponent")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Move(name: moves[appChoice], isSelected: true)
                    .frame(width: 200, height: 200, alignment: .center)
                
                Spacer()
                
                Text("Choose your move")
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                Text("to \(shouldWin ? "win" : "lose")")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                
                VStack(spacing: 25) {
                    HStack(spacing: 20) {
                        ForEach(0 ..< moves.count) { number in
                            Button(action: {
                                if number != appChoice {
                                    playerChoice = number
                                }
                            }, label: {
                                Move(name: moves[number], isSelected: playerChoice == number)
                                    .frame(width: 100, height: 100, alignment: .center)
                            })
                        }
                    }
                    
                    Button(action: {
                        computeScore()
                    }, label: {
                        Text("Shoot")
                            .frame(width: 100, height: 50)
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: .purple, radius: 2)
                    })
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text(alertTitle), message: Text(alertBody), dismissButton: .default(gameHasEnded ? Text("Try again") : Text("Next")))
                    })
                }
                
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                Text("Round \(roundNumber)/10")
                    .foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
