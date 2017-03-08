//
//  UILabelTimerAll.swift
//  colorCheckGame
//
//  Created by Tony Marko on 05/03/2017.
//  Copyright © 2017 Tony Marko. All rights reserved.
//

import UIKit

class UILabelTimerAll: UILabelTimerClass {

    override func timerUpdate() {
        
        self.time -= 0.01
        
        if self.time < 0 {
            self.time = 0
            self.timer.invalidate()            
            
            NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "GameOver")))
            
            self.textColor = UIColor.red
            UIView.animate(withDuration: 0.27, animations: {
                self.transform = CGAffineTransform.init(scaleX: 1.25, y: 1.1)
                self.alpha = 0.4
                
            }, completion: { (value: Bool) in
                UIView.animate(withDuration: 0.24, animations: {
                    self.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
                    self.alpha = 1.0
                }, completion: { (value: Bool) in
                    UIView.animate(withDuration: 1.67, animations: {
                        self.alpha = 0.1
                    }, completion: { (value: Bool) in
                        UIView.animate(withDuration: 1.67, animations: {
                            self.textColor = UIColor(colorLiteralRed: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
                            self.alpha = 1.0
                        })
                    })
                })
            })
        }
        
    }

    func addTime (amount: Float32) {
        
        self.time += amount
    }
}
