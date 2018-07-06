//
//  Concentration.swift
//  Concentration
//
//  Created by Amber Spadafora on 7/3/18.
//  Copyright © 2018 Amber Spadafora. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards: [Card] = []
    var matchedCards: [Card] = []
    var score: Int = 0
    var flipCount: Int = 0
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        flipCount += 1
        cards[index].numberOfTimesSeen += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    matchedCards.append(cards[index])
                    matchedCards.append(cards[matchIndex])
                    if matchedCards.count == cards.count {
                        print("You've won!")
                    }
                } else {
                    [cards[index], cards[matchIndex]].forEach({ (card) in
                        if card.numberOfTimesSeen > 1 { score -= 1}
                    })
                }
                indexOfOneAndOnlyFaceUpCard = nil
                cards[index].isFaceUp = true
            } else {
                // either 0 cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            let matchingCard = card
            cards += [card, matchingCard]
        }
        var last = cards.count - 1
        while last > 0 {
            let rand = Int(arc4random_uniform(UInt32(last)))
            cards.swapAt(last, rand)
            last -= 1
        }
        
        
    }
}
