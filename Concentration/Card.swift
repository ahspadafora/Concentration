//
//  Card.swift
//  Concentration
//
//  Created by Amber Spadafora on 7/3/18.
//  Copyright © 2018 Amber Spadafora. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var numberOfTimesSeen: Int = 0
    var identifier: Int
    
    static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    static var identifierFactory = 0
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
