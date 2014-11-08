//
//  Snake.swift
//  SwiftSnake
//
//  Created by Sam Burnstone on 02/11/2014.
//  Copyright (c) 2014 Sam Burnstone. All rights reserved.
//

import Foundation
import UIKit

class Snake {
    
    var bodyParts: [BodyPart] = []
    var movements: [Movement] = []
    
    let bodyPartSize = CGSize(width: 20, height: 20)
    let numberOfTailParts: Int = 2
    let speed = 20
    let animationDuration: NSTimeInterval
    
    let gameView: UIView
    
    init(gameView: UIView, startPoint: CGPoint, animationDuration: NSTimeInterval) {
        self.gameView = gameView
        self.animationDuration = animationDuration
        createInitialSnakeAtStartPoint(startPoint)
    }
    
    private func createInitialSnakeAtStartPoint(point: CGPoint) {
        let startingRect = CGRect(origin: point, size: bodyPartSize)
        
        let head = BodyPart(frame: startingRect, headPart: true)
        bodyParts.append(head)
        
        gameView.addSubview(head)
        
        for index in 1...numberOfTailParts {
            let xOffsetFromHead = bodyPartSize.width * CGFloat(-index)
            let body = BodyPart(frame: CGRectOffset(startingRect, xOffsetFromHead, 0), headPart: false)
            bodyParts.append(body)
            gameView.addSubview(body)
        }
    }
    
    func moveBodyParts() {
        
        // Go through movements
        for movement in movements {
            let partToMove = bodyParts[movement.currentIndexToMove]
            partToMove.currentDirection = movement.direction
            
            movement.currentIndexToMove++
        }
        
        for part in bodyParts {
            part.moveBodyPartWithSpeed(speed, duration: animationDuration)
        }
        
        removeIrrelevantMovements()
    }
    
    func addNewMovement(direction: BodyPart.MovementDirection) {
        let newMovement = Movement(direction: direction)
        movements.append(newMovement)
    }
    
    /**
    Returns the front-most view of the snake (the head)

    :returns An optional BodyPart instance, representing the snake's head
    */
    func headBodyPart() -> BodyPart! {
        return bodyParts.first;
    }
    
    func removeFromView() {
        for part in bodyParts {
            part.removeFromSuperview()
        }
        
        bodyParts.removeAll(keepCapacity: false)
    }
    
    private func removeIrrelevantMovements() {
        
        let tempMovementsCopy = movements
        
        // Remove any movements that are no longer relevant
        for index in 0..<tempMovementsCopy.count {
            if tempMovementsCopy[index].currentIndexToMove == bodyParts.count {
                movements.removeAtIndex(index)
            }
        }
    }
    
}
