//
//  ArrayExtensions.swift
//  Concentration
//
//  Created by Jason Stelzel on 8/14/22.
//

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
