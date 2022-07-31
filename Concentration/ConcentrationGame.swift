//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Jason Stelzel on 7/27/22.
//

import Foundation

// Model
struct ConcentrationGame<CardContent> {
    private(set) var cards: Array<Card>
    
    mutating func choose(_ card: Card) {
//        if let chosenIndex = index(of: card) {
//        This line of code is reduced to the line of code below it and it eliminates the need for the block of code below!
//        if let chosenIndex = cards.firstIndex(where: { aCardInTheCardsArray in aCardInTheCardsArray.id == card.id}) {
            if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) {

            cards[chosenIndex].isFaceUp.toggle()
        }
        
        print("chosenCard = \(cards)")
    }
    
//    No longer needed!
    
//    func index(of card: Card) -> Int? {
//        for index in 0..<cards.count {
//            if cards[index].id == card.id {
//                return index
//            }
//        }
//        return nil
//    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairsOfCards x 2 cards to cards array
        // the id satisfies the Identifiable requirement by using the Int counting of the pairIndex in the for loop
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
