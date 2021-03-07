//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Anthony You on 01/03/2021.
//

import SwiftUI

struct FlagImage: View {
    let fileName: String
    
    var body: some View {
        Image(fileName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.white, lineWidth: 1))
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.5), radius: 2)
    }
}

// shake effect from objc.io https://talk.objc.io/episodes/S01E173-building-a-shake-animation
struct ShakeEffect: GeometryEffect {
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX: -30 * sin(position * 2 * .pi), y: 0))
    }

    init(shakes: Int) {
        position = CGFloat(shakes)
    }

    var position: CGFloat
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    
    @State private var hintMessage = ""
    
    @State private var animationAmounts = [0.0, 0.0, 0.0]
    @State private var opacityAmounts = [1.0, 1.0, 1.0]
    @State private var shakeAnimationAmounts = [0, 0, 0]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        withAnimation {
                            self.flagTapped(number)
                        }
                    }, label: {
                        FlagImage(fileName: self.countries[number])
                            .rotation3DEffect(.degrees(self.animationAmounts[number]), axis: (x: 0, y: 1, z: 0))
                            .opacity(self.opacityAmounts[number])
                            .modifier(ShakeEffect(shakes: self.shakeAnimationAmounts[number] * 2))
                    })
                }
                
                HStack {
                    Text("Score:")
                    Text("\(score)")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .foregroundColor(.white)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(hintMessage), dismissButton: .default(Text("Continue")) {
                self.opacityAmounts = [1.0, 1.0, 1.0]
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            animationAmounts[number] += 360
            
            for (index, _) in opacityAmounts.enumerated() {
                if index != number {
                    opacityAmounts[index] = 0.25
                }
            }
            
            scoreTitle = "Correct 👏"
            score += 1
            hintMessage = "Good one! Your score is \(score)"
        } else {
            shakeAnimationAmounts[number] = 2
            
            for (index, _) in opacityAmounts.enumerated() {
                if index != number {
                    opacityAmounts[index] = 0.25
                }
            }
            
            scoreTitle = "Wrong 👎"
            score -= 1
            hintMessage = "That's the flag of \(countries[correctAnswer])! Your score is \(score)"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
