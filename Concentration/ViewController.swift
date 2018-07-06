//
//  ViewController.swift
//  Concentration
//
//  Created by Amber Spadafora on 7/3/18.
//  Copyright © 2018 Amber Spadafora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
    
    var currentGameTheme: [String] = []
    var emojiForCardDict: [Int: String] = [:]
    
    var flipCount: Int = 0 {
        didSet {
           flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    override func viewDidLoad() {
        currentGameTheme = getRandomTheme()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let card = game.cards[index]
            let button = cardButtons[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.6632423401, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.6632423401, blue: 0, alpha: 1)
            }
            
        }
        scoreLabel.text = "Score: \(game.score)"
    }
    
    func emoji(for card: Card) -> String {
        if emojiForCardDict[card.identifier] == nil, currentGameTheme.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(currentGameTheme.count)))
            emojiForCardDict[card.identifier] = currentGameTheme.remove(at: randomIndex)
        }
        return emojiForCardDict[card.identifier] ?? "?"
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        resetGame()
        updateViewFromModel()
        
    }
    
    func getRandomTheme() -> [String] {
        let random = Int(arc4random_uniform(UInt32(themes.count)))
        return themes[random]
    }
    
    func resetGame() {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        currentGameTheme = getRandomTheme()
        emojiForCardDict = [:]
        flipCount = 0
        updateViewFromModel()
    }
    
    var themes: [[String]] = [
        ["🐶","🐰","🐨","🐷","🐽","🐯","🦊","🐱","🐭","🐻","🦁","🐸","🙊","🐦","🐤","🦆","🐺","🦄","🐌","🦋","🦎","🦑","🐙"],
        ["❤️", "💛","💚","💙","💜","🖤","💔","❣️","💕","💞","💓","💗","💖","💘","💝","💟","☮️","☸️","☯️","♈️","♊️","💌","🔮"],
        ["⚽️", "🏀","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🥅","🏒","🏑","🏏","⛳️","🏹","🎣","🥊","🥋","⛸","🎿","⛷","⛹️‍♀️"]]
}

