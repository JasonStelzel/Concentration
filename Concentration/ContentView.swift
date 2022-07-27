//
//  ContentView.swift
//  Concentration
//
//  Created by Jason Stelzel on 7/26/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
// closing braces are down below so you can try each Zstack
// 5th phase (most reduced by removing return and parens)
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .stroke(lineWidth: 3)

            Text("Hello, Jason!")

        }
        .padding(.horizontal)
        .foregroundColor(.red)

// 4th phase (reduce more by using default parameters)
//        return ZStack() {
//            RoundedRectangle(cornerRadius: 25)
//                .stroke(lineWidth: 3)
//
//            Text("Hello, Jason!")
//
//        }
//        .padding(.horizontal)
//        .foregroundColor(.red)

       
// 3rd phase (reduce with hanging closure)
//        return ZStack(content: {
//            RoundedRectangle(cornerRadius: 25)
//                .stroke(lineWidth: 3)
//
//            Text("Hello, Jason!")
//
//        })
//        .padding(.horizontal)
//        .foregroundColor(.red)

  
// 2nd phase (add Zstack)
//        return ZStack(alignment: .center, content: {
//            RoundedRectangle(cornerRadius: 25)
//                .stroke(lineWidth: 3)
//
//            Text("Hello, Jason!")
//
//        })
//        .padding(.horizontal)
//        .foregroundColor(.red)

        
// 1st phase of development
//        return RoundedRectangle(cornerRadius: 25)
//            .stroke(lineWidth: 10)
//            .padding(.horizontal)
//            .foregroundColor(.orange)
//
//        Text("Hello, Jason!").foregroundColor(.orange).padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

    }
}

            
            
            






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
