//: Playground - noun: a place where people can play

import UIKit

var str = "panda"

var blank = "_____"

var guess: Character = "a"

var newStr = ""

for index in str.characters.indices{
    if(str[index] == guess){
        newStr += String(guess)
    }
    else{
        newStr += "_"
    }
}

print(newStr)