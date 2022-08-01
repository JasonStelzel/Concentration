//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Jason Stelzel on 7/27/22.
//

import Foundation

// Model
struct ConcentrationGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
//            let faceUpCardIndices = cards.indices.filter(<#T##isIncluded: (Int) throws -> Bool##(Int) throws -> Bool#>)
            
//            let faceUpCardIndices = cards.indices.filter({ index in cards[index].isFaceUp })
//            return faceUpCardIndices.oneAndOnly // reduces to the single line below
            
//            cards.indices.filter({ index in cards[index].isFaceUp }).oneAndOnly // which can be further reduced with the default $0 argument
            
              cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly // it's a good idea to avoid trailing closure syntax and keep parens here because another function is called on result of first closure
        }
        
//      set { for index in cards.indices { cards[index].isFaceUp = (index == newValue) } } // further reduced with .forEach, default $0 argument and trailing closure syntax
        
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) {
        // the comma at the ends of the first 3 lines means the same thing as "&&"
        // and $0 is an implicit argument brought "in" to the function (so there's no { $0 in $0.id == card.id })
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                // whatever CardContent type is supplied must conform to Equatable (above) to allow for comparison here
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        // add numberOfPairsOfCards x 2 cards to cards array
        // the id satisfies the Identifiable requirement by using the Int counting of the pairIndex in the for loop
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
