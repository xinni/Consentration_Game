//
//  Card.swift
//  Consentratin
//
//  Created by Xin Ni on 2/3/18.
//  Copyright © 2018 Stanford University. All rights reserved.
//

import Foundation

struct Card: Hashable{
    var hashValue: Int {return self.indentifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        
        return lhs.indentifier == rhs.indentifier
    }
    
    
    
    var isFaceUp = false
    var isMatched = false
    var hadBeenSeen = false
    private var indentifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifer() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.indentifier = Card.getUniqueIdentifer()
    }
    
}
