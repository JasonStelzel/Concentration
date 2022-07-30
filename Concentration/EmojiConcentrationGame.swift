//
//  EmojiConcentrationGame.swift
//  Concentration
//
//  Created by Jason Stelzel on 7/27/22.
//

import SwiftUI

// ViewModel (which instantiates the model)
class EmojiConcentrationGame: ObservableObject {
    
    static let emojis = ["🚁", "🚀", "✈️", "⛴", "🛩", "🚗", "🚌", "🚐", "🚛", "🚑", "🚕", "🚚", "🚢", "🚒", "🚓", "🚎", "🚖", "🛵", "🛴", "🛺", "🛻", "🚜"]

    static func createConcentrationGame() -> ConcentrationGame<String> {
        ConcentrationGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
// this var (var objectWillChange: ObservableObjectPublisher) is generated for free when you declare EmojiConcentrationGame as an ObservableObject
// You don't need to actually declare it and in fact it will generate an error if you do.
// You could then fire objectWillChange.send() to announce to the world anytime you change the model (and need something to update on the screen)
// but it will be automatically fired if you wrap the observed instance of the object with the @Published property wrapper
// The other parts that go with this are the ObservableObject type (in the ViewModel) and @ObservedObject (in the View) <- ContentView
// These mirror each other because the @ObservedObject declared in the View (EmojiConcentrationGame) extends ObservableObject in the ViewModel
// along with this @Published property wrapper (on the model)
       
    @Published private var model: ConcentrationGame<String> = createConcentrationGame()

    var cards: Array<ConcentrationGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: ConcentrationGame<String>.Card) {
        model.choose(card)
    }
}
