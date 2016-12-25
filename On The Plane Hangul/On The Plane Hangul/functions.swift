//
//  functions.swift
//  On The Plane Hangul
//
//  Created by Jay Steingold on 12/23/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import Foundation

//Default value for decks
var decks = [Deck?](repeating: nil, count: 10) //Array of arrays of cards (hardcode bad)
//For saving data about the user's deck
let defaults = UserDefaults.standard

//Saves array as an object to userDefaults
func save() {
    let savedData = NSKeyedArchiver.archivedData(withRootObject: decks)
    let defaults = UserDefaults.standard
    defaults.set(savedData, forKey: "decks")
}
