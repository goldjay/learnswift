//
//  ViewController.swift
//  On The Plane Hangul
//
//  Created by Jay Steingold on 10/8/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UITableViewController {
    var levels = Array(1...10)
    
    var decks = [[String]()]
    var deck1 = [String]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        deck1 += ["ah", "eo", "eu", "i", "o"]
        decks.insert(deck1, at: 0) //CHANGE TO VARIABLE AND MADE LOOP?
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return levels.count
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quiz", for: indexPath)
        cell.textLabel?.text = "Level " + String(levels[indexPath.row])
        cell.tag = levels[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Names the view controller we want to navigate to
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            //Find and load level string from the disk
            if let levelFilePath = Bundle.main.path(forResource: "level\(indexPath.row + 1)", ofType: "txt") {
                print("FOUND THE FILE")
                if let levelContents = try? String(contentsOfFile: levelFilePath) {
                    var lines = levelContents.components(separatedBy: "\n")
                    print("LINES before shuffle: ")
                    print(lines)
                    lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
                    print("LINES after shuffle: ")
                    print(lines)
                   
                    //Enumerated gives us the position of each item in the lines array
                    for (index, line) in lines.enumerated() {
                        //Splits each line into answer and clue
                        let parts = line.components(separatedBy: ": ")
                        let question = parts[0]
                        print(parts)
                        //let clue = parts[1]
                        
                        //print(answer)
                        //print(clue)
 
                    
                   /*
                        //Need to do +1 because the index actually starts at 0
                        clueString += "\(index + 1). \(clue)\n"
                        
                        //Remove all "|" characters fromt the string
                        let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                        solutionString += "\(solutionWord.characters.count) letters\n"
                        solutions.append(solutionWord)
                        
                        //Turns answer into question by breaking into parts and placing in an array
                        let bits = answer.components(separatedBy: "|")
                        letterBits += bits
 
                    */
                    }
                }
            }
            
            
            vc.selectedDeck = decks[indexPath.row]
            
            
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

