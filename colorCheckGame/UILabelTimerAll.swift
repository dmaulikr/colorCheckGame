//
//  UILabelTimerAll.swift
//  colorCheckGame
//
//  Created by Tony Marko on 05/03/2017.
//  Copyright © 2017 Tony Marko. All rights reserved.
//

import UIKit

class UILabelTimerAll: UILabel {

    var timeAmount: Float32 = 0.0
    
    func addTime (amount: Float32) {
        
        self.timeAmount += amount
        self.text = String(format: "%.2f", timeAmount)
    }
    
    func resetTime () {
        self.timeAmount = 0.0
        self.text = String(format: "%.2f", timeAmount)
    }

}
