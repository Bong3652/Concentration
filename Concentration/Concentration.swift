//
//  Concentration.swift
//  Concentration
//
//  Created by APPLE on 12/13/18.
//  Copyright © 2018 Bong. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    var indexOfOnlyCard: Int?
    var score = 0
    
    init (numPairs:Int) {
        for _ in 0..<numPairs {
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
        var temp = [Card]()
        for _ in cards {
            if (cards.count > 0) {
                let num = Int(arc4random_uniform(UInt32(cards.count)))
                temp.append(cards.remove(at: num))
            }
        }
        cards = temp
    }
    
    func chooseCard(index: Int) {
//        if (cards[index].isFacedUp) {
//            cards[index].isFacedUp = false;
//        } else {
//            cards[index].isFacedUp = true;
//        }
        if !cards[index].isMatched {
            if let matchIndex = indexOfOnlyCard {
                if cards[matchIndex].id == cards[index].id && index != matchIndex {
                    cards[matchIndex].isMatched = true;
                    cards[index].isMatched = true;
                    self.score += 2;
                }
                cards[index].isFacedUp = true;
                indexOfOnlyCard = nil;
            } else {
                for index in 0..<cards.count {
                    cards[index].isFacedUp = false;
                }
                cards[index].isFacedUp = true;
                indexOfOnlyCard = index;
                //self.score -= 1
            }
        }
    }
    
    func isCleared(cards: [Card]) -> Bool {
        for card in cards {
            if !card.isMatched {
                return false;
            }
        }
        return true;
    }
    
    func newGame(numPairs: Int) {
        self.cards = [Card]()
        self.indexOfOnlyCard = nil;
        self.score = 0
        for _ in 0..<numPairs {
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
        var temp = [Card]()
        for _ in cards {
            if (cards.count > 0) {
                let num = Int(arc4random_uniform(UInt32(cards.count)))
                temp.append(cards.remove(at: num))
            }
        }
        cards = temp
    }
}
