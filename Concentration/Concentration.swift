//
//  Concentration.swift
//  Concentration
//
//  Created by Bilal Hashmi on 5/12/18.
//  Copyright © 2018 University of Michigan. All rights reserved.
//

import Foundation


class Concentration {
    private(set) var cards =  Array<Card>() //initializes and creates and empty array
    
    private var indexofOneandOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if (foundIndex == nil) {
                        foundIndex = index
                    }
                        //by now, it will be the case where we have 2 face up cards
                    else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        
        set(newIndex) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newIndex)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index),
               "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        
        if !cards[index].isMatched {
            //case 1: check if cards match
            if let matchIndex = indexofOneandOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }
            //case 2: either no cards or 2 cards are face up
            else {
                indexofOneandOnlyFaceUpCard = index
            }
        }
    }

    init(numberofPairsofCards: Int) {
        assert(numberofPairsofCards > 0, "Concetration.init - you must have atleast one pair of cards")
        //the syntax 0.. is a countable range FROM ZERO TO LESS THAN NUMPAIRS
        //the underscore _ means its irrelevant like for i /we dont care
        for _ in 0..<numberofPairsofCards {
            let card = Card()
            cards.append(card)
            cards.append(card)
            //alternatively you could do cards += [card, card]
            
        }
        //shuffles the cards
        cards.shuffle()
    }
} //Concentration Class 

extension Array {
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
