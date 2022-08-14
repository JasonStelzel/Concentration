//
//  EmojiConcentrationGame.swift
//  Concentration
//
//  Created by Jason Stelzel on 7/27/22.
//

import SwiftUI

// ViewModel (which instantiates the model)
class EmojiConcentrationGame: ObservableObject {
    typealias Card = ConcentrationGame<String>.Card
    
    private static let emojis = ["🚁", "🚀", "✈️", "⛴", "🛩", "🚗", "🚌", "🚐", "🚛", "🚑", "🚕", "🚚", "🚢", "🚒", "🚓", "🚎", "🚖", "🛵", "🛴", "🛺", "🛻", "🚜"]

    private static func createConcentrationGame() -> ConcentrationGame<String> {
        ConcentrationGame<String>(numberOfPairsOfCards: 8) { pairIndex in
            emojis[pairIndex]
        }
    }
       
    @Published private var model = createConcentrationGame()

    var cards: Array<Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiConcentrationGame.createConcentrationGame()
    }
    
}
