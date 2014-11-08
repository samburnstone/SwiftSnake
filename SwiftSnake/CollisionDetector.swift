//
//  CollisionDetector.swift
//  SwiftSnake
//
//  Created by Sam Burnstone on 08/11/2014.
//  Copyright (c) 2014 Sam Burnstone. All rights reserved.
//

import Foundation
import UIKit

protocol SnakeCollisionDelegate {
    func snakeDidCollideWithWall()
    func snakeDidCollideWithFoodItem()
}

class CollisionDetector {
    
    /// The frame the snake must stay within
    let viewFrame: CGRect
    
    /// Food spawner holding current food item on screen
    let foodSpawner: FoodSpawner
    
    var delegate: SnakeCollisionDelegate?
    
    init(viewFrame: CGRect, foodSpawner: FoodSpawner) {
        self.viewFrame = viewFrame
        self.foodSpawner = foodSpawner
    }
    
    func checkForCollision(snake: Snake) {
        
        if delegate? == nil {
            println("Remember to set CollisionDetector's delegate!")
        }
        
        let headPart = snake.headBodyPart()
        
        // Check for collision with walls
        if CGRectGetMinX(headPart.frame) < 0 {
            delegate?.snakeDidCollideWithWall()
        }
        else if CGRectGetMaxX(headPart.frame) > viewFrame.size.width {
            delegate?.snakeDidCollideWithWall()
        }
        else if CGRectGetMinY(headPart.frame) < 0 {
            delegate?.snakeDidCollideWithWall()
        }
        else if CGRectGetMaxY(headPart.frame) > viewFrame.size.height {
            delegate?.snakeDidCollideWithWall()
        }
        else {
            // Check for collision with food item with all snake body parts
            for bodyPart in snake.bodyParts {
                if CGRectIntersectsRect(bodyPart.frame, foodSpawner.foodItemView.frame) {
                    delegate?.snakeDidCollideWithFoodItem()
                }
            }
        }
        
    }
    
}
