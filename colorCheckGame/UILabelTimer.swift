//
//  UILabelTimer.swift
//  colorCheckGame
//
//  Created by Tony Marko on 26/02/2017.
//  Copyright © 2017 Tony Marko. All rights reserved.
//

import UIKit

class UILabelTimer: UILabel {

    var time: Float32 = 0.0
    var timer: Timer!
    
    static var level : [String:Float32] = [
        "start" : 10.0,
        "easy"  : 8.0,
        "nomral": 6.0,
        "hard"  : 4.0,
        "insane": 2.0,
        "out": 0.0
    ]
    
    func updateLabel() {
        self.text = String(format: "%.2f", time)
    }
    
    func startTimer (fromTime: Float32) {
        
        time = fromTime
        timer = Timer.scheduledTimer(timeInterval: 0.01,
                                     target: self,
                                     selector: #selector(UILabelTimer.timerUpdate),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func timerUpdate() {
        
        self.time -= 0.03
        
        if self.time < 0 {
            self.time = 0
            self.timer.invalidate()
            print("timer stopped")
        }
        
        updateLabel()
    }
    
    func resetTime () {
        self.time = 0.0
        updateLabel()
    }

}
