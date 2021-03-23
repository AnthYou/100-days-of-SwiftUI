//
//  CardView.swift
//  Flashzilla
//
//  Created by Anthony You on 19/03/2021.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled

    let card: Card
    
    let isReplayingWrongCards: Bool
    
    var removal: ((_ isCorrect: Bool) -> Void)? = nil
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    @State private var feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(getBackgroundColor(offset: offset))
                )
                .shadow(radius: 10)

            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        /// order is important: we need to rotate before moving it otherwise it will go on y-axis instead of x-axis
        .rotationEffect(.degrees(Double(offset.width / 5))) /// we divided the offset.width (how far user has moved the card) by 5 so we don't spin the card too fast
        .offset(x: offset.width * 5, y: 0) /// we multiplied offset.width by 5 so we don't need to do a long swipe to complete the animation
        .opacity(2 - Double(abs(offset.width / 50))) /// we use 1/50 of drag amount (otherwise it will fade too quickly), abs() to get absolute value so we don't care about swiping left or right and substract from 2 so card stays opaque until 50 points (2 opacity is same than 1)
        .accessibility(addTraits: .isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation /// gesture.translation = where the user has drag into
                    self.feedback.prepare()
                }

                .onEnded { _ in
                    if abs(self.offset.width) > 100 { /// if user has moved more than 100 points (meaning opacity is now 0), we consider card removed
                        if self.offset.width > 0 {
                            self.feedback.notificationOccurred(.success)
                        } else {
                            self.feedback.notificationOccurred(.error)
                        }
                        
                        if (self.isReplayingWrongCards) && (self.offset.width < 0) {
                            self.offset = .zero
                        }
                        
                        self.removal?(self.offset.width > 0) // That question mark in there means the closure will only be called if it has been set.
                    } else { /// else we put the position back to origin, i.e. offset = 0
                        self.offset = .zero
                    }
                }
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .animation(.spring())
    }
    
    func getBackgroundColor(offset: CGSize) -> Color {
        if offset.width > 0 {
            return .green
        }
        
        if offset.width < 0 {
            return .red
        }
        
        return .white
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example, isReplayingWrongCards: true)
            .previewLayout(.fixed(width: 2532 / 3.0, height: 1170 / 3.0))
            .environment(\.horizontalSizeClass, .regular)
            .environment(\.verticalSizeClass, .compact)
    }
}
