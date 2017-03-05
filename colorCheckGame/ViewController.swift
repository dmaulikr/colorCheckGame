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
    
    @IBAction func bckColor1(_ sender: UIBarButtonItem) {
        changeBckColorTo(colorWithRed: 255, green: 255, blue: 255)
    }
    @IBAction func bckColor2(_ sender: UIBarButtonItem) {
        changeBckColorTo(colorWithRed: 252, green: 250, blue: 246)
    }
    @IBAction func bckColor3(_ sender: UIBarButtonItem) {
        changeBckColorTo(colorWithRed: 56, green: 55, blue: 53)
    }
    
    
    @IBAction func resetGame(_ sender: UIBarButtonItem) {
        startNewGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNewGame()
    }

    func startNewGame() {
        
        rightAnswers.resetScore()
        wrongAnswers.resetScore()
        additionalTime.resetTime()
        currentTimer.resetTime()
        
        currentTimer.startTimer(fromTime: UILabelTimer.level["start"]!)
    }
    
    func changeBckColorTo(colorWithRed red: Float, green: Float, blue: Float) {
        
        let normalizedRed = (1.0 / 255) * red
        let normalizedGreen = (1.0 / 255) * green
        let normalizedBlue = (1.0 / 255) * blue
        self.view.backgroundColor = UIColor(colorLiteralRed: normalizedRed,
                                            green: normalizedGreen,
                                            blue: normalizedBlue,
                                            alpha: 1.0)
    }


}

