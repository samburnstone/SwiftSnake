//
//  ViewController.swift
//  SwiftSnake
//
//  Created by Sam Burnstone on 02/11/2014.
//  Copyright (c) 2014 Sam Burnstone. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SnakeCollisionDelegate, UIAlertViewDelegate {

    var snake: Snake!
    var gameLoopTimer: NSTimer!
    var collisionDetector: CollisionDetector!
    
    let updateInterval: NSTimeInterval = 0.2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initalize collision detector
        collisionDetector = CollisionDetector(viewFrame: view.frame)
        collisionDetector.delegate = self
        
        startGame()
    }
    
    func startGame() {
        // Create snake
        snake = Snake(gameView: view, startPoint: CGPoint(x: 100, y: 100), animationDuration: updateInterval)
        
        // Create the timer
        gameLoopTimer = NSTimer.scheduledTimerWithTimeInterval(updateInterval, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        collisionDetector.checkForCollision(snake.headBodyPart())
        snake.moveBodyParts()
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
    
    // MARK:- CollisionDetector Delegate Methods
    func snakeDidCollideWithWall() {
        // Stop the timer
        gameLoopTimer.invalidate()
        
        // Alert the player by showing an alert view for now
        UIAlertView(title: "You crashed into the wall!", message: "Better luck next time", delegate: self, cancelButtonTitle: "Whoops!").show()
    }
    
    // MARK:- UIAlertView Delegate Methods
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        // Remove snake from view
        snake.removeFromView()
        
        // Restart game
        startGame()
    }
}