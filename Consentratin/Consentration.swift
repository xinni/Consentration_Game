//
//  Consentration.swift
//  Consentratin
//
//  Created by Xin Ni on 2/3/18.
//  Copyright © 2018 Stanford University. All rights reserved.
//

import Foundation

struct Consentration {
    
    //understand why this is private(set)
    private(set) var cards = [Card]()
    
    private(set) var flipCount: Int
    
    private(set) var scoreCount: Int
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        //TODO: get familar with this part
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        //TODO: get familiar with this
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    scoreCount += 2
                } else {
                    if cards[matchIndex].hadBeenSeen {
                        scoreCount -= 1
                    } else {
                        cards[matchIndex].hadBeenSeen = true
                    }
                    if cards[index].hadBeenSeen {
                        scoreCount -= 1
                    } else {
                        cards[index].hadBeenSeen = true
                    }
                }
                cards[index].isFaceUp = true
            } else {
                // two or none is face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        
        cards = [Card]()
        flipCount = 0
        scoreCount = 0
        
        for _ in 1 ... numberOfPairsOfCards {
            let card = Card()
            let matchingCard = card
            cards.append(card)
            cards.append(matchingCard)
        }
        
        for index in cards.indices {
            let randomIndex = cards.count.arc4random
            cards.swapAt(index, randomIndex)
        }
    }

}
 
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
