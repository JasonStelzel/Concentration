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
       
    @Published private var model: ConcentrationGame<String> = createConcentrationGame()

    var cards: Array<ConcentrationGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: ConcentrationGame<String>.Card) {
        model.choose(card)
    }
}
