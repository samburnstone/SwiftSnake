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
    var foodSpawner: FoodSpawner!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var updateInterval: NSTimeInterval = 0.2
    var timeElapsedSinceLastSpeedIncrease: NSTimeInterval = 0.0
    let timeIntervalUntilSpeedIncrease: NSTimeInterval = 10.0
    let minUpdateInterval: NSTimeInterval = 0.1
    
    /// Store the user's current score (incremented when collects food items)
    var score: Int = 0 {
        didSet {
            // Update score label when score updated
            scoreLabel.text = "\(score)"
        }
    }
    /// The amount added on to user's score when a food item is picked up
    let foodItemPickupScore = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create food spawner
        foodSpawner = FoodSpawner(viewFrame: view.frame)
        
        // Initalize collision detector
        collisionDetector = CollisionDetector(viewFrame: view.frame, foodSpawner: foodSpawner)
        collisionDetector.delegate = self
        
        startGame()
    }
    
    func startGame() {
        
        // Reset game variables
        score = 0
        timeElapsedSinceLastSpeedIncrease = 0.0
        updateInterval = 0.2
        
        // Create snake
        snake = Snake(gameView: view, startPoint: CGPoint(x: 100, y: 100))
        
        // Add first food item to view
        view.insertSubview(foodSpawner.newFoodItem(), belowSubview: snake.headBodyPart())
        
        // Create the timer
        gameLoopTimer = NSTimer.scheduledTimerWithTimeInterval(updateInterval, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        collisionDetector.checkForCollision(snake)
        snake.moveBodyParts()
        
        // Increase speed if necessary
        timeElapsedSinceLastSpeedIncrease += updateInterval

        if timeIntervalUntilSpeedIncrease - timeElapsedSinceLastSpeedIncrease <= 0.0 {
            
            if updateInterval >= minUpdateInterval {
                updateInterval -= 0.01
                timeElapsedSinceLastSpeedIncrease = 0.0;
                
                gameLoopTimer.invalidate()
                gameLoopTimer = NSTimer.scheduledTimerWithTimeInterval(updateInterval, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
            }
        }
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
    
    func snakeDidCollideWithFoodItem() {
        foodSpawner.foodItemView.removeFromSuperview()
        // Make sure snake appears above food item
        view.insertSubview(foodSpawner.newFoodItem(), belowSubview: snake.headBodyPart())
        
        // Increment score
        score += foodItemPickupScore
    }
    
    // MARK:- UIAlertView Delegate Methods
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        // Remove snake from view
        snake.removeFromView()
        
        // Start new game
        startGame()
    }
}