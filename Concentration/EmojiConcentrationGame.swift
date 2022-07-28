//
//  EmojiConcentrationGame.swift
//  Concentration
//
//  Created by Jason Stelzel on 7/27/22.
//

import SwiftUI

// essentially you are making a function to fulfill the needs of "createCardContent" argument as follows: (see 2nd commented out line below)
//func makeCardContent(index: Int) -> String {
//    return "😀"
//}


// ViewModel (which instantiates the model)
class EmojiConcentrationGame {
    
// /* the following commented lines of code show the progression to the optimal solution for how code is reduced in Swift
// This line starts with what Swift is calling for with its own code completion*/
//    private(set) var model: ConcentrationGame<String> = ConcentrationGame<String>(numberOfPairsOfCards: 4, createCardContent: <#(Int) -> String#>)
    
    
// /* this line of code is paired with the function above and would satisfy the requirement of providing a function for the argument "createCardContent"
// however, it is bulky, requiring a separate, named function which is not the way Swift best handles this requirement */
//    private(set) var model: ConcentrationGame<String> = ConcentrationGame<String>(numberOfPairsOfCards: 4, createCardContent: makeCardContent)
    
    
// /* taking the *content* of the function above and inserting it inline is a good start, but as you will see, it can be substantially reduced!
// When you do this, you replace the opening brace "{" with the word "in" and then move the brace earlier to include the arguments
// So now the whole thing is enclosed within the curly braces and where the function itself began, the word "in" indicates this.
// So, starting with "{" you are saying that the the arguments supplied to the function as well as what it returns are "in" this function. */
//
//    private(set) var model: ConcentrationGame<String> = ConcentrationGame<String>(numberOfPairsOfCards: 4, createCardContent: { (index: Int) -> String in
//        return "😀"
//    })
    

// /* Because of type inference, we don't actually need to specify the argument type or the return type */
//
//    private(set) var model: ConcentrationGame<String> = ConcentrationGame<String>(numberOfPairsOfCards: 4, createCardContent: { (index) in
//        return "😀"
//    })


// /* And then, to clean things up more, we don't need the parentheses around *index* or the *return* in front of "😀" and can put it on 1 line */
//
//    private(set) var model: ConcentrationGame<String> = ConcentrationGame<String>(numberOfPairsOfCards: 4, createCardContent: { index in "😀" })
    

// /* And then if we recognize that we don't actually pass an index into this closure we can substitute the underbar */
//
//    private(set) var model: ConcentrationGame<String> = ConcentrationGame<String>(numberOfPairsOfCards: 4, createCardContent: { _ in "😀" })
        
        
// /* And then finally, since this is the last argument to the function so we can remove the comma and argument label and move the closing parentheses that encloses it
// This is the most reduced version of this function */
//
    private(set) var model: ConcentrationGame<String> = ConcentrationGame<String>(numberOfPairsOfCards: 4) { _ in "😀" }
       

    var cards: Array<ConcentrationGame<String>.Card> {
        return model.cards
    }
}
