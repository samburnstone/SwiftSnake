//
//  FoodSpawner.swift
//  SwiftSnake
//
//  Created by Sam Burnstone on 08/11/2014.
//  Copyright (c) 2014 Sam Burnstone. All rights reserved.
//

import Foundation
import UIKit

class FoodSpawner {
    
    enum FoodItem: Int {
        case Apple
        case Banana
        case Watermelon
        case Pomegranate
    }
    
    /// Record the size of the view we're going to add the food items to
    let viewFrame: CGRect
    
    /// Food item currently on screen
    let foodItemView = UIImageView(frame: CGRectMake(0, 0, 20, 20))
    
    init(viewFrame: CGRect) {
        self.viewFrame = viewFrame
    }
    
    func newFoodItem() -> UIImageView {
        let item = randomFoodItem()
        
        var image: UIImage
        
        switch item {
            case .Apple: image = UIImage(named: "Apple")!
            case .Banana: image = UIImage(named: "Banana")!
            case .Pomegranate: image = UIImage(named: "Pomegranate")!
            case .Watermelon: image = UIImage(named: "Watermelon")!
        }
        
        foodItemView.image = image
        foodItemView.center = randomPositionOnScreen()
        
        return foodItemView
    }
    
    /// Generate random x and y positions, ensuring the image stays within bounds of view
    private func randomPositionOnScreen() -> CGPoint {
        let maxXValue = UInt32(viewFrame.size.width - foodItemView.frame.size.width/2)
        let randXPos = CGFloat(arc4random_uniform(maxXValue + 1))
        
        let maxYValue = UInt32(viewFrame.size.height - foodItemView.frame.size.height/2)
        let randYPos = CGFloat(arc4random_uniform(maxYValue + 1))
        
        return CGPoint(x: randXPos, y: randYPos)
    }
    
    /// Generate a random food item to display
    private func randomFoodItem() -> FoodItem {
        let maxEnumValue = FoodItem.Pomegranate.rawValue + 1
        
        let randRawValue = arc4random_uniform(UInt32(maxEnumValue))
        
        return FoodItem(rawValue: Int(randRawValue))!
    }
    
}