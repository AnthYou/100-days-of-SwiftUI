//
//  ContentView.swift
//  Flashzilla
//
//  Created by Anthony You on 18/03/2021.
//

import SwiftUI
import CoreHaptics

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

enum SheetType {
    case editSheet, settingsSheet
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled

    // @State private var cards = [Card](repeating: Card.example, count: 10)
    @State private var cards = [Card]()
    
    @State private var isActive = true
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
    @State private var engine: CHHapticEngine?
    
    @State private var isReplayingWrongCards = true
    
    @State private var showingSheet = false
    @State private var sheetType: SheetType = .editSheet

    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if timeRemaining == 0 {
                    Text("Time's up!")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                } else {
                    Text("Time: \(timeRemaining)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(Color.black)
                                .opacity(0.75)
                        )
                }
                
                ZStack {
                    ForEach(cards) { card in
                        CardView(card: card, isReplayingWrongCards: self.isReplayingWrongCards) { isCorrect in
                            if self.isReplayingWrongCards && !isCorrect {
                                self.restackCard(at: self.index(for: card))
                                return
                            }
                            
                            withAnimation {
                                self.removeCard(at: self.index(for: card))
                            }
                        }
                        .stacked(at: self.index(for: card), in: self.cards.count)
                        .allowsHitTesting(self.index(for: card) == self.cards.count - 1)
                        .accessibility(hidden: self.index(for: card) < self.cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0) // end user interactivity when user's out of time
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Button(action: {
                        self.sheetType = .settingsSheet
                        self.showingSheet = true
                    }, label: {
                        Image(systemName: "gear")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    })
                    
                    Spacer()

                    Button(action: {
                        self.sheetType = .editSheet
                        self.showingSheet = true
                    }) {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()

                    HStack {
                        Button(action: {
                            if self.isReplayingWrongCards {
                                self.restackCard(at: self.cards.count - 1)
                                return
                            }
                            
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))
                        Spacer()

                        Button(action: {
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard self.isActive else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            
                if self.timeRemaining == 2 {
                    self.prepareHaptics()
                } else if self.timeRemaining == 0 {
                    self.complexEnding()
                }
                
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if self.cards.isEmpty == false {
                self.isActive = true
            }
        }
        .sheet(isPresented: $showingSheet, onDismiss: resetCards) {
            if sheetType == .editSheet {
                EditCards()
            } else {
                SettingsView(isReplayingWrongCards: $isReplayingWrongCards)
            }
        }
        .onAppear(perform: resetCards)
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        cards.remove(at: index)
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func restackCard(at index: Int) {
        guard index >= 0 else { return }
        
        let card = cards[index]
        cards.remove(at: index)
        cards.insert(card, at: 0)
    }
    
    func index(for card: Card) -> Int {
        return cards.firstIndex(where: { $0.id == card.id }) ?? 0
    }
    
    func resetCards() {
        // cards = [Card](repeating: Card.example, count: 10)
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
    
    // MARK: Core Haptics
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexEnding() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        // get several taps of increasing then decreasing intensity and sharpness
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 2532 / 3.0, height: 1170 / 3.0))
            .environment(\.horizontalSizeClass, .regular)
            .environment(\.verticalSizeClass, .compact)
    }
}
