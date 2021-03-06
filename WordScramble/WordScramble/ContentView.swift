//
//  ContentView.swift
//  WordScramble
//
//  Created by Anthony You on 04/03/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                    
                GeometryReader { listProxy in
                    List(usedWords, id: \.self) { word in
                        GeometryReader { itemProxy in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                    .foregroundColor(self.getColor(listProxy: listProxy, itemProxy: itemProxy))
                                Text(word)
                            }
                            .accessibilityElement(children: .ignore)
                            .accessibility(label: Text("\(word), \(word.count) letters"))
                            .frame(width: itemProxy.size.width, alignment: .leading)
                            .offset(x: self.getOffset(listProxy: listProxy, itemProxy: itemProxy), y: 0)
                        }
                    }
                }
                
                
                Text("Score: \(score)")
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(leading: Button(action: startGame, label: {
                Image(systemName: "gobackward")
                Text("Restart")
            }))
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func getOffset(listProxy: GeometryProxy, itemProxy: GeometryProxy) -> CGFloat {
        let listHeight = listProxy.size.height
        let listStart = listProxy.frame(in: .global).minY
        let itemStart = itemProxy.frame(in: .global).minY
        
        let itemPercent =  (itemStart - listStart) / listHeight * 100
        
        let thresholdPercent: CGFloat = 60
        let indent: CGFloat = 9
        
        if itemPercent > thresholdPercent {
            return (itemPercent - (thresholdPercent - 1)) * indent
        }
        
        return 0
    }
    
    func getColor(listProxy: GeometryProxy, itemProxy: GeometryProxy) -> Color {
        let itemPercent = getItemPercent(listProxy: listProxy, itemProxy: itemProxy)
        let colorValue = Double(itemPercent / 100)

        return Color(red: 2 * colorValue, green: 2 * (1 - colorValue), blue: 0)
    }

    func getItemPercent(listProxy: GeometryProxy, itemProxy: GeometryProxy) -> CGFloat {
        let listHeight = listProxy.size.height
        let listStart = listProxy.frame(in: .global).minY
        let itemStart = itemProxy.frame(in: .global).minY

        let itemPercent = (itemStart - listStart) / listHeight * 100

        return itemPercent
    }
    
    func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")

                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"

                // If we are here everything has worked, so we can exit
                return
            }
        }

        // If were are *here* then there was a problem ??? trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word.")
            return
        }
        
        guard isLongEnough(word: answer) else {
            wordError(title: "Word too short", message: "Word must contains at least 3 characters.")
            return
        }
        
        guard isDifferentFromStartingWord(word: answer) else {
            wordError(title: "Same word as starting word", message: "Be more creative")
            return
        }
        
        usedWords.insert(answer, at: 0)
        score += answer.count
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isLongEnough(word: String) -> Bool {
        return word.count > 2
    }
    
    func isDifferentFromStartingWord(word: String) -> Bool {
        return word != rootWord
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
