//
//  ContentView.swift
//  Concentration
//
//  Created by Jason Stelzel on 7/26/22.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🚁", "🚀", "✈️", "⛴"]
    @State var emojiCount = 4 // inference makes this an Int
    
    var body: some View {
        VStack {
            HStack {
    //            CardView(isFaceUp: false) // Must provide default if value not provided in declaration of isFaceUp in CardView below
                ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                    CardView(content: emoji)
                }
                
            }
            HStack{
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .foregroundColor(.red)
    }
    
    
//    Button(action: <#T##() -> Void#>, label: <#T##() -> Label#>)
    var add: some View {
            Button(action: {
            emojiCount += 1
        }, label: {
            // install sf-symbols first from Apple
            // then RUN sf-symbols to access database of symbols to choose from
            Image(systemName:"plus.circle")
//            VStack {
//                Text("Add")
//                Text("Card")
//            }
        })
    }
    
    var remove: some View {
        Button(action: {
            emojiCount -= 1
        }, label: {
            // install sf-symbols first from Apple
            // then RUN sf-symbols to access database of symbols to choose from
            Image(systemName:"minus.circle")
//            VStack {
//                Text("Remove")
//                Text("Card")
//            }
        })

    }
}
            
struct CardView: View {
    var content: String
//    var isFaceUp: Bool // if default not provided in declaration, then value must be provided at point of use above
//    var isFaceUp: Bool { return false } // what is actually happening in line below
    @State var isFaceUp = false // @State adds a pointer to make this memory indirectly accessed so that it can be updated.
    
    var body: some View {
        ZStack {
//            var shape: RoundedRectangle = RoundedRectangle(cornerRadius: 20) // can be reduced by using type inference (letting Swift figure out the type)
//            var shape = RoundedRectangle(cornerRadius: 20) // this should be a "let"
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white) // must fill with a color (in this case "white") otherwise taps can fall through the default "clear color" to the background creating an intermittent experience
                shape.stroke(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            } else {
                shape.fill().foregroundColor(.red)

            }

        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}
            






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPod touch (7th generation)")
        ContentView()
            .preferredColorScheme(.light)
            .previewDevice("iPod touch (7th generation)")
    }
}

