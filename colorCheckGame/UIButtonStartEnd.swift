//
//  UIButtonStartEnd.swift
//  colorCheckGame
//
//  Created by Tony Marko on 05/03/2017.
//  Copyright © 2017 Tony Marko. All rights reserved.
//

import UIKit

class UIButtonStartEnd: UIButton {

    var stateStart = false {
        didSet {
            if !self.stateStart {
                self.setTitle("Tap to start game", for: .normal)
            } else {
                UIView.animate(withDuration: 0.97, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    self.transform = CGAffineTransform.init(translationX: 0, y: 500)
                    self.alpha = 0
                })
            }
        }
    }
    
    func gameOver () {
        
        UIView.animate(withDuration: 0.97, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.transform = CGAffineTransform.init(translationX: 0, y: 0)
            self.alpha = 1
        })
    }
    
    
}
