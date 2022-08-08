//
//  Cardify.swift
//  Concentration
//
//  Created by Jason Stelzel on 8/1/22.
//

import SwiftUI

struct Cardify: AnimatableModifier {

    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get{ rotation }
        set{ rotation = newValue }
    }
    
    var rotation: Double // in Degrees
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth) // stroke INSIDE object vs. half and half with just stroke
            } else {
                shape.fill()
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))

    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 5
        static let lineWidth: CGFloat = 2
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
