//
//  classes.swift
//  On The Plane Hangul
//
//  Created by Jay Steingold on 11/19/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import Foundation
import UIKit

/*
class Card: NSObject, NSCoding {
    var guessedRight: Int!
    var guessedWrong: Int!
    var question: String!
    var answer: String!
    
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
        self.guessedRight = 0
        self.guessedWrong = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        question = aDecoder.decodeObject(forKey: "question") as! String
        answer = aDecoder.decodeObject(forKey: "answer") as! String
        guessedRight = aDecoder.decodeInteger(forKey: "guessedRight")
        guessedWrong = aDecoder.decodeInteger(forKey: "guessedWrong")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(question, forKey: "question")
        aCoder.encode(answer, forKey: "answer")
        aCoder.encode(guessedWrong, forKey: "guessedWrong")
        aCoder.encode(guessedRight, forKey: "guessedRight")
        
         print("card encoded!")
    }
}
*/

class Deck: NSObject, NSCoding {
    var cards: [[String]] //Array of arrays of strings
    var highScore: Int
    var completed: Bool
    
    init(cards: [[String]]) {
        self.cards = cards
        self.highScore = 0
        self.completed = false
    }
    
    required init(coder aDecoder: NSCoder) {
        print("DECODING!")
        
        cards = aDecoder.decodeObject(forKey: "cards") as?
            [[String]] ?? [[String]]()
        highScore = aDecoder.decodeObject(forKey: "highScore") as? Int ?? aDecoder.decodeInteger(forKey: "highScore")
        completed = aDecoder.decodeObject(forKey: "completed") as? Bool ?? aDecoder.decodeBool(forKey: "completed")
    }
    
    func encode(with aCoder: NSCoder) {
        print("ENCODING")
        
        //aCoder.encode(cards, forKey: "cards")
        aCoder.encode(highScore, forKey: "highScore")
        aCoder.encode(completed, forKey: "completed")
        
        print("Deck encoded!")
    }
}
