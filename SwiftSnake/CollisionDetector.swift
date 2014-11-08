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
}

class CollisionDetector {
    
    /// The frame the snake must stay within
    let viewFrame: CGRect
    
    var delegate: SnakeCollisionDelegate?
    
    init(viewFrame: CGRect) {
        self.viewFrame = viewFrame
    }
    
    func checkForCollision(objectToCheck: UIView) {
        
        if delegate? == nil {
            println("Remember to set CollisionDetector's delegate!")
        }
        
        if CGRectGetMinX(objectToCheck.frame) < 0 {
            delegate?.snakeDidCollideWithWall()
        }
        else if CGRectGetMaxX(objectToCheck.frame) > viewFrame.size.width {
            delegate?.snakeDidCollideWithWall()
        }
        else if CGRectGetMinY(objectToCheck.frame) < 0 {
            delegate?.snakeDidCollideWithWall()
        }
        else if CGRectGetMaxY(objectToCheck.frame) > viewFrame.size.height {
            delegate?.snakeDidCollideWithWall()
        }
    }
    
}
