//
//  UIButtonStartEnd.swift
//  colorCheckGame
//
//  Created by Tony Marko on 05/03/2017.
//  Copyright © 2017 Tony Marko. All rights reserved.
//

import UIKit

class UIButtonStartEnd: UIButton {

    var stateStart = true {
        didSet {
            if self.stateStart {
                self.setTitle("Tap to start game", for: .normal)
            } else {
                self.setTitle("Game over", for: .normal)
            }
        }
    }

}
