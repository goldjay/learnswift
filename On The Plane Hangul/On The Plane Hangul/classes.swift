//
//  classes.swift
//  On The Plane Hangul
//
//  Created by Jay Steingold on 11/19/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import Foundation

class Card{
    var guessedRight: Int
    var guessedWrong: Int
    var question: String
    var answer: String
    
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
        self.guessedRight = 0
        self.guessedWrong = 0
    }
}

class Deck{
    var cards: [Card]
    var highScore: Int
    var completed: Bool
    
    init(cards: [Card]) {
        self.cards = cards
        self.highScore = 0
        self.completed = false
    }
    /*
    init() {
        self.cards = [Card()]
        self.highScore = 0
        self.completed = false
        self.num = 0
    }
 */
}
