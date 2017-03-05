//
//  ViewController.swift
//  colorCheckGame
//
//  Created by Tony Marko on 26/02/2017.
//  Copyright © 2017 Tony Marko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTimer: UILabelTimer!
    @IBOutlet weak var additionalTime: UILabelTimerAll!
    @IBOutlet weak var rightAnswers: UILabelScores!
    @IBOutlet weak var wrongAnswers: UILabelScores!
    @IBOutlet weak var bckColor1: UIBarButtonItemColor!
    @IBOutlet weak var bckColor2: UIBarButtonItemColor!
    @IBOutlet weak var bckColor3: UIBarButtonItemColor!
    
    var currentBckColorFrom: UIColor!
    
    @IBAction func bckColor1(_ sender: UIBarButtonItem) {
        changeBckColorTo(color: bckColor1.color)
        bckColor1.isActive = true
    }
    @IBAction func bckColor2(_ sender: UIBarButtonItem) {
        changeBckColorTo(color: bckColor2.color)
        bckColor2.isActive = true
    }
    @IBAction func bckColor3(_ sender: UIBarButtonItem) {
        changeBckColorTo(color: bckColor3.color)
        bckColor3.isActive = true
    }
    
    @IBAction func resetGame(_ sender: UIBarButtonItem) {
        startNewGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNewGame()
        
        bckColor1.isActive = true
        currentBckColorFrom = bckColor1.color
    }

    func startNewGame() {
        
        rightAnswers.resetScore()
        wrongAnswers.resetScore()
        additionalTime.resetTime()
        currentTimer.resetTime()
        
        currentTimer.startTimer(fromTime: UILabelTimer.level["start"]!)
    }
    
    func changeBckColorTo(color: UIColor) {
        
        let steps: CGFloat = 20
        var step = 1
        
        let addRed = Float((color.components.red - self.currentBckColorFrom.components.red) / steps)
        let addGreen = Float((color.components.green - self.currentBckColorFrom.components.green) / steps)
        let addBlue = Float((color.components.blue - self.currentBckColorFrom.components.blue) / steps)
        
        let _ = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
            
            self.currentBckColorFrom = UIColor(colorLiteralRed: Float(self.currentBckColorFrom.components.red) + addRed,
                                          green: Float(self.currentBckColorFrom.components.green) + addGreen,
                                          blue: Float(self.currentBckColorFrom.components.blue) + addBlue, alpha: 1.0)
            self.view.backgroundColor = self.currentBckColorFrom
            step += 1
            
            if CGFloat(step) > steps {
                timer.invalidate()
                self.view.backgroundColor = color
            }
        }
        
        self.bckColor1.isActive = false
        self.bckColor2.isActive = false
        self.bckColor3.isActive = false
    }


}

extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let color = coreImageColor
        return (color.red, color.green, color.blue, color.alpha)
    }
}

