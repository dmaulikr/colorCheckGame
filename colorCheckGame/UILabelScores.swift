//
//  UILabelScores.swift
//  colorCheckGame
//
//  Created by Tony Marko on 26/02/2017.
//  Copyright © 2017 Tony Marko. All rights reserved.
//

import UIKit

class UILabelScores: UILabel {
    
    var score :Int32 = 0
    
    func addScore() {
        self.score += 1
        self.text = String(score)
    }
    
    func resetScore() {
        self.score = 0
        self.text = String(score)
    }

}
