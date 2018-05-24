//
//  ViewController.swift
//  Concentration
//
//  Created by Bilal Hashmi on 5/9/18.
//  Copyright © 2018 University of Michigan. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberofPairsofCards: numberofPairsofCards)
    
    private var emojiThemes = [
        ["🍞", "🥜", "🥧", "🍓", "🍉", "🍇", "🍒", "🍌"],
        ["💀", "👻", "👽", "🙀", "🦇", "🕷", "🕸", "🎃"],
        ["🏓", "🚴‍♂️", "🥋", "🎸", "🎯", "🎮", "🎹", "🎲"],
        ["🚚", "🏍", "✈️", "🚜", "🚎", "🚲", "🚂", "🛴"],
        ["👚", "👕", "👖", "👔", "👗", "👓", "👠", "🎩"],
        ["🐶", "🐭", "🦊", "🦋", "🐢", "🐸", "🐵", "🐞"],
    ]
    
    var numberofPairsofCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("chosen card was not within the cardButtons")
        }
    }
    
    @IBAction private func playAgain(_ sender: UIButton) {
        //resets the game
        game = Concentration(numberofPairsofCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
        emojiChoices = emojiThemes[emojiThemes.count.arc4random]
        flipCount = 0
    }
    

    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card =  game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal);
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
                
            else {
                button.setTitle("", for: UIControlState.normal);
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0) : #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            }
        }
    }
    
    private lazy var emojiChoices: [String] = emojiThemes[emojiThemes.count.arc4random]

    //gonna use card identifiers as key to get emoji as value
    private var emoji = Dictionary<Int, String>() //or use [Int:String]()
    
    private func emoji(for card: Card) -> String {
        print(emojiChoices)
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                let randomIndex = emojiChoices.count.arc4random
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex) //this ensures each identifier has a unique emoji
            }
        return emoji[card.identifier] ?? "?"
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
