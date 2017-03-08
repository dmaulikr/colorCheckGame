//
//  ViewController.swift
//  colorCheckGame
//
//  Created by Tony Marko on 26/02/2017.
//  Copyright © 2017 Tony Marko. All rights reserved.
//

import UIKit

enum gameLevel: Float32 {
    case start = 10.0
    case easy = 8.0
    case normal = 6.0
    case hard = 4.0
    case insane = 2.0
    case theEnd = 0.0
}

class ViewController: UIViewController {

    @IBOutlet weak var currentTimer: UILabelTimer!
    @IBOutlet weak var additionalTime: UILabelTimerAll!
    @IBOutlet weak var rightAnswers: UILabelScores!
    @IBOutlet weak var wrongAnswers: UILabelScores!
    @IBOutlet weak var bckColor1: UIBarButtonItemColor!
    @IBOutlet weak var bckColor2: UIBarButtonItemColor!
    @IBOutlet weak var bckColor3: UIBarButtonItemColor!
    @IBOutlet weak var buttonStartEnd: UIButtonStartEnd!
    
    var currentBckColorFrom: UIColor!
    var canceledStart = false
    
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
        if !buttonStartEnd.stateStart {
            canceledStart = true
            buttonStartEnd.cancelledStart = true
            buttonStartEnd.gameOver()
            startNewGame()
            buttonStartEnd.stateStart = true
        }
    }
    
    @IBAction func buttonStartEnd(_ sender: UIButtonStartEnd) {
        
        buttonStartEnd.stateStart = !buttonStartEnd.stateStart
        
        if !buttonStartEnd.stateStart {

            self.perform(#selector(ViewController.startFire), with: nil, afterDelay: 2.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startNewGame()
        
        bckColor1.isActive = true
        currentBckColorFrom = bckColor1.color
    }

    func startNewGame() {
        
        view.layer.removeAllAnimations()
        currentTimer.layer.removeAllAnimations()
        additionalTime.layer.removeAllAnimations()
        currentTimer.superview?.layer.removeAllAnimations()
        additionalTime.superview?.layer.removeAllAnimations()
        
        rightAnswers.resetScore()
        wrongAnswers.resetScore()
        additionalTime.resetTime()
        currentTimer.resetTime()
    }
    
    func startFire() {
        
        if canceledStart {
            
            self.perform(#selector(ViewController.startFireWait), with: nil, afterDelay: 1.0)
            
        } else {
            currentTimer.startTimer(fromTime: gameLevel.insane.rawValue)
            additionalTime.startTimer(fromTime: gameLevel.insane.rawValue)
        }
    }
    
    func startFireWait () {
        canceledStart = false
        buttonStartEnd.cancelledStart = false
    }
    
    func gameOver() {
        print("game over")
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
