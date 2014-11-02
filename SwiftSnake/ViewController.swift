//
//  ViewController.swift
//  SwiftSnake
//
//  Created by Sam Burnstone on 02/11/2014.
//  Copyright (c) 2014 Sam Burnstone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var snake: Snake!
    var gameLoopTimer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create snake
        snake = Snake(gameView: view, startPoint: CGPoint(x: 100, y: 100))
        
        gameLoopTimer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        snake.moveBodyParts()
        
        snake.removeIrrelevantMovements()
    }
    
    // MARK:- Change of movement button selection methods
    @IBAction func moveRight(sender: AnyObject) {
        snake.addNewMovement(BodyPart.MovementDirection.Right)
    }
    
    @IBAction func moveLeft(sender: AnyObject) {
        snake.addNewMovement(BodyPart.MovementDirection.Left)
    }

    @IBAction func moveUp(sender: AnyObject) {
        snake.addNewMovement(BodyPart.MovementDirection.Up)
    }

    @IBAction func moveDown(sender: AnyObject) {
        snake.addNewMovement(BodyPart.MovementDirection.Down)
    }
}