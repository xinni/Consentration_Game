//
//  ViewController.swift
//  Consentratin
//
//  Created by Xin Ni on 2/2/18.
//  Copyright © 2018 Stanford University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Consentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        //flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Wrong Card!")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.scoreCount)"
    }
    
    private var helloween = ["👻", "🎃", "🙈", "😈", "🤡", "🙀", "💀", "☠️", "👹"]
    private var animals = ["🐶", "🐱", "🦊", "🐯", "🦅", "🐷", "🐰", "🐥", "🦄"]
    private var sports = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏓", "🎱", "🏹", "🥊"]
    private var faces = ["😅", "😍", "😘", "🤩", "😎", "🤪", "🤓", "😳", "😴"]
    private var foods = ["🍏", "🍋", "🍓", "🥥", "🥑", "🍆", "🌶", "🧀", "🥕"]
    private var flags = ["🇦🇺", "🇨🇿", "🇪🇺", "🇯🇵", "🇻🇳", "🇨🇦", "🇨🇳", "🇨🇮", "🇬🇷"]
    private lazy var themeChoices = [helloween, animals, sports, faces, foods, flags]
    private lazy var emojiChoices = themeChoices[themeChoices.count.arc4random]
    
    private var emoji = Dictionary<Card, String>()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil {
            //let randomIndex = emojiChoices.count.arc4random
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
        
//        if emoji[card.indentifier] != nil {
//            return emoji[card.indentifier]!
//        } else {
//            return "?"
//        }
        //do not use ! here or will crash
    }
    
    @IBAction private func touchRestart(_ sender: UIButton) {
        
        //TODO: reset the game
        game = Consentration.init(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
        emojiChoices = themeChoices[themeChoices.count.arc4random]
    }
    
}

