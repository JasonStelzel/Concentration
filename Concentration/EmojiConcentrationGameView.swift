//
//  EmojiConcentrationGameView.swift
//  Concentration
//
//  Created by Jason Stelzel on 7/26/22.
//

import SwiftUI

// View
struct EmojiConcentrationGameView: View {

    @ObservedObject var viewModel: EmojiConcentrationGame // the instance of this particular game
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))] ){
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}
            
struct CardView: View {
    let card: ConcentrationGame<String>.Card
        
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3) // stroke INSIDE object vs. half and half with just stroke
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}
            






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiConcentrationGame()
        EmojiConcentrationGameView(viewModel: game)
            .preferredColorScheme(.dark)
            .previewDevice("iPod touch (7th generation)")
        EmojiConcentrationGameView(viewModel: game)
            .preferredColorScheme(.light)
            .previewDevice("iPod touch (7th generation)")
    }
}

