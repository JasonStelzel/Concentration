//
//  ConcentrationApp.swift
//  Concentration
//
//  Created by Jason Stelzel on 7/26/22.
//

import SwiftUI

@main
struct ConcentrationApp: App {
    let game = EmojiConcentrationGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
