//
//  BodyPart.swift
//  SwiftSnake
//
//  Created by Sam Burnstone on 02/11/2014.
//  Copyright (c) 2014 Sam Burnstone. All rights reserved.
//

import UIKit

class BodyPart: UIView {
    
    enum MovementDirection {
        case Left
        case Right
        case Up
        case Down
    }
    
    // Keep track of the part's current direction of motion
    var currentDirection = MovementDirection.Right
    
    init(frame: CGRect, headPart: Bool) {
        super.init(frame: frame)
        
        // Set view background depending on whether view is snake's head or not
        backgroundColor = headPart == true ? UIColor(red:0.85, green:0.55, blue:0.25, alpha:1) : UIColor(red:0.69, green:0.1, blue:0.08, alpha:1)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
    Move the body part
    
    :params speed The offset to move the body part by
    :params duration The animation duration of this view
    */
    func moveBodyPartWithSpeed(speed: Int) {
        
        var movementVector: CGVector = CGVectorMake(0, 0)
        
        switch currentDirection {
            case .Right:
                movementVector = CGVector(dx: speed, dy: 0)
            case .Left:
                movementVector = CGVector(dx: -speed, dy: 0)
            case .Up:
                movementVector = CGVector(dx: 0, dy: -speed)
            case .Down:
                movementVector = CGVector(dx: 0, dy: speed)
        }
        
        self.frame = CGRectOffset(self.frame, movementVector.dx, movementVector.dy)
    }
}
