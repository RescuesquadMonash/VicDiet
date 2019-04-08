//
//  FoodObject.swift
//  VicDiet
//
//  Created by Ming Yang on 6/4/19.
//  Copyright © 2019 Ming Yang. All rights reserved.
//

import UIKit

class FoodObject: NSObject {

    var name : String
    var protein: NSNumber
    var surveyFlag: String
    var calcium: NSNumber
    var totalFat: NSNumber
    var sodium: NSNumber
    var vitaminC: NSNumber
    var vitaminA: NSNumber
    
    init(name: String, protein: NSNumber, surveyFlag: String,calcium: NSNumber,totalFat: NSNumber, sodium: NSNumber,vitaminC: NSNumber,vitaminA: NSNumber) {
        self.name = name
        self.protein = protein
        self.surveyFlag = surveyFlag
        self.calcium = calcium
        self.totalFat = totalFat
        self.sodium = sodium
        self.vitaminC = vitaminC
        self.vitaminA = vitaminA
        
    }
    
    
    
}
