//
//  Card.swift
//  Concentration
//
//  Created by APPLE on 12/13/18.
//  Copyright © 2018 Bong. All rights reserved.
//

import Foundation

struct Card {
    var isFacedUp = false
    var isMatched = false
    var id: Int
    
    static var generator = 0
    static func getGenerated() -> Int {
        generator += 1;
        return generator;
    }
    init() {
        self.id = Card.getGenerated()
    }
}
