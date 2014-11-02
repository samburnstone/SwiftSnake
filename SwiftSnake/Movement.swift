//
//  Movement.swift
//  SwiftSnake
//
//  Created by Sam Burnstone on 02/11/2014.
//  Copyright (c) 2014 Sam Burnstone. All rights reserved.
//

import Foundation

class Movement {
    let direction: BodyPart.MovementDirection
    var currentIndexToMove: Int = 0
    
    init(direction: BodyPart.MovementDirection) {
        self.direction = direction
    }
}