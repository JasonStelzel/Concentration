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
    
    var add: some View {
            Button(action: {
            emojiCount += 1
        }, label: {
            Image(systemName:"plus.circle")
        })
    }
    
    var remove: some View {
        Button(action: {
            emojiCount -= 1
        }, label: {
            Image(systemName:"minus.circle")
        })

    }
}
            
struct CardView: View {
    var content: String
    @State var isFaceUp = false
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
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

