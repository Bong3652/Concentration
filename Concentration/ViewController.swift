//
//  ViewController.swift
//  Concentration
//
//  Created by APPLE on 12/13/18.
//  Copyright © 2018 Bong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numPairs: (cards.count / 2))
    @IBOutlet var cards: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var againButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "FlipCount: \(flipCount)"
        }
    }
    
    
    @IBAction func flipped(_ sender: UIButton) {
        //let num = cards.firstIndex(of: sender)!
        //flipCard(withEmoji: sender.currentTitle!, on: sender)
        let cardNumber = cards.index(of: sender)
        game.chooseCard(index: cardNumber!)
        updateView(withButton: sender)
        flipCount += 1
    }
    
    func updateView(withButton button: UIButton) {
        for index in cards.indices {
            let currentButton = cards[index]
            let gameCard = game.cards[index]
            if (gameCard.isFacedUp) {
                currentButton.setTitle(giveEmo(for: gameCard), for: UIControl.State.normal)
                if game.isCleared(cards: game.cards) {
                    againButton.isHidden = false;
                }
            } else {
                currentButton.setTitle("", for: UIControl.State.normal)
                if gameCard.isMatched {
                    currentButton.isHidden = true;
                }
            }
        }
        scoreLabel.text = "Score: \(game.score)"
    }
    
    lazy var groupEmojis: [[String]] = [christmasEmojis, zoasEmojis, emotionEmojis];
    var zoasEmojis = ["🐭", "🐮", "🐯", "🐰", "🐉", "🐍"]
    var christmasEmojis = ["🎄", "🎅", "🌟", "☃️", "🦌", "🎁"]
    var emotionEmojis = ["🙂", "😙", "😜", "🥺", "😱", "🤥"]
    lazy var emojis = groupEmojis[Int(arc4random_uniform(UInt32(groupEmojis.count)))]
    
    var emojiDictionary = Dictionary<Int, String>()
    
    func giveEmo(for card: Card) -> String {
        if (emojiDictionary[card.id] == nil && emojis.count > 0) {
            let num = Int(arc4random_uniform(UInt32(emojis.count)))
            emojiDictionary[card.id] = emojis.remove(at: num)
        }
        return emojiDictionary[card.id]!
    }
    
    @IBAction func againPressed(_ sender: UIButton) {
        flipCount = 0;
        game.newGame(numPairs: cards.count / 2)
        for card in cards {
            card.isHidden = false;
        }
        emojis = groupEmojis[Int(arc4random_uniform(UInt32(groupEmojis.count)))]
        updateView(withButton: sender)
        againButton.isHidden = true;
    }
    
}


