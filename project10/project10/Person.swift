//
//  Person.swift
//  project10
//
//  Created by Jay Steingold on 11/26/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import UIKit

//Added coding to be able to save in userDefaults
class Person: NSObject, NSCoding {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image 
    }
    
    //Converts coded object back to name and image properties
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name")  as! String
        image = aDecoder.decodeObject(forKey: "image") as! String
    }
    
    //Converts name and image into an object
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
    }

}
