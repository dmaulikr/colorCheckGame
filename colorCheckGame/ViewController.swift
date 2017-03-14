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
    @IBOutlet weak var buttonResetGame: UIBarButtonItem!
    
    var timer : Timer!
    
    var currentBckColorFrom: UIColor!
    var gameTime = 0
    
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
        
        if  buttonStartEnd.stateStart && gameTime > 2 {
            
            resetGameTime()
            buttonStartEnd.stateStart = false
            additionalTime.isResetGame = true
            buttonStartEnd.gameOver()
            startNewGame()
        }
    }
    
    @IBAction func buttonStartEnd(_ sender: UIButtonStartEnd) {
        
        if !buttonStartEnd.stateStart {
            buttonStartEnd.stateStart = true
            startNewGame()
            
            DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 2)) {
                self.startFire()
            }
        } else {
            buttonStartEnd.stateStart = false
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startNewGame()
        
        bckColor1.isActive = true
        currentBckColorFrom = bckColor1.color
        
        let button = UIButton(frame: CGRect(x: 300, y: 300, width: 50, height: 50))
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(ViewController.buttonRandom), for: .touchUpInside)
        view.addSubview(button)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "GameOver"), object: nil, queue: nil) { (Notification) in
            self.gameOver()
        }
    }
    
    func buttonRandom() {
        checkScore(tag: Int(arc4random_uniform(100)))
    }
    
    // MARK: - Common Actions

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
        
        currentTimer.startTimer(fromTime: gameLevel.insane.rawValue)
        additionalTime.startTimer(fromTime: gameLevel.insane.rawValue)
    
        timer = Timer.scheduledTimer(withTimeInterval: 0.50, repeats: true) { (Timer) in
            self.gameTime += 1
            print(self.gameTime)
        }
    }
    
    func gameOver() {
        buttonStartEnd.setTitle("Game Over", for: .normal)
        buttonStartEnd.gameOver()
        resetGameTime()
    }
    
    func resetGameTime() {
        timer.invalidate()
        gameTime = 0
    }
    
    // MARK: - Game Engine
    
    func showCircles() {
        
    }
    
    func checkScore(tag: Int) {
        
        if tag > 50 {
            rightAnswers.addScore()
        } else {
            wrongAnswers.addScore()
        }
    }
    
    // MARK: - Utilities
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
