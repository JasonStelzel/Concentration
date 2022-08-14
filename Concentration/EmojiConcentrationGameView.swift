//
//  EmojiConcentrationGameView.swift
//  Concentration
//
//  Created by Jason Stelzel on 7/26/22.
//

import SwiftUI

// View
struct EmojiConcentrationGameView: View {

    @ObservedObject var game: EmojiConcentrationGame // the instance of this particular game
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        VStack {
            gameBody
            deckBody
            shuffle
        }
        .padding()
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiConcentrationGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiConcentrationGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiConcentrationGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.dealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiConcentrationGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0) // searches for each card by id and then returns the additive inverse of its array index in the game.cards array.
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if isUndealt(card) || card.isMatched && !card.isFaceUp {
                Color.clear
            } else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.75)) {
                            game.choose(card)
                        }
                    }
            }
            
        }
        .foregroundColor(.red)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card)) // using a function to set the zIndex of each card to the additive inverse of its index in the shuffled set of game.cards (the number you would add to its array index to make zero) so that the visual stacking order matches the array order of the shuffled deck with the smallest ID on top.  Because zero would then be "the smallest" zIndex when you invert the original game.cards array indices into negative zIndex numbers, array index 1 (shuffled card #1) becomes zIndex -1 which places it below index 0 (card #0) so card 0 will remain on top (as higher numbered zIndex views are placed on top of lower numbered zIndex views).  Previously, with the cards generated in array index order and then shuffled, the array order would not match the zIndex view stacking order.  By using the array index as a key and inverting it into the zIndex for each card in order as it appears by its index in the shuffled array of cards, you can deal the cards in array index order and they will appear to be dealt from "the top" of the deck as the ordering of the views will now have views with z-indices of 0, -1, -2, -3, -4 etc assigned to each card id as needed based on how they were shuffled and where they were found, one by one as each card is sent to the zIndex function (the array index isn't known when they are sent to the zIndex function, just the card itself is known so we have to look up where it is in the shuffled deck by its id).
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            // deal cards so that we can delay having them on screen for animation purposes
            for card in game.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                game.shuffle()
            }
        }
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
}
            
struct CardView: View {
    let card: EmojiConcentrationGame.Card
        
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 115-90)).padding(5).opacity(0.5)
                Text(card.content)
                // implicit animations can be overridden with .transactions
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(.linear(duration: 1).repeatCount(9, autoreverses: false))
                    .font(Font.system(size:DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
    }
}
            






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiConcentrationGame()
        game.choose(game.cards.first!)
        return EmojiConcentrationGameView(game: game)
//            .preferredColorScheme(.dark)
//            .previewDevice("iPod touch (7th generation)")
//        EmojiConcentrationGameView(game: game)
//            .preferredColorScheme(.light)
//            .previewDevice("iPod touch (7th generation)")
    }
}

