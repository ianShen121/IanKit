//
//  Common.swift
//  ISKit
//
//  Created by master on 2019/4/18.
//  Copyright © 2019 com.ian.pop. All rights reserved.
//

import Foundation
import UIKit

public enum ShowType{
    case present,dismiss
}


public enum ShowAnimationType{
    case normal
    case scale(factor:CGFloat)
}


public enum ShowDirection{
    case fromTop
    case fromLeft
    case fromRight
    case fromBottom
    case none
}


public enum PresentHeightType{
    case fullScreen
    case halfScreen
    case custom(height:CGFloat)
}

public enum PresentWidthType {
    case fullScreen
    case halfScreen
    case custom(width:CGFloat)
}

public enum PresentHLocationType{
    case left
    case right
    case center
    case custom(x:CGFloat)
}

public enum PresentVLocationType{
    case top
    case bottom
    case center
    case custom(y:CGFloat)
}



public struct ISPresentConfiguration {
    public var direction:ShowDirection = .fromBottom
    public var animateDuration:TimeInterval = 0.2
    public var cornerRadius:CGFloat = 4
    public var dimmingViewFrame:CGRect = UIScreen.main.bounds
    public var animateType:ShowAnimationType = .normal
    private(set) var heightType:PresentHeightType = .halfScreen
    private(set) var widthType:PresentWidthType = .halfScreen
    private(set) var hLocationType:PresentHLocationType = .center
    private(set) var vLocationType:PresentVLocationType = .center
    public init(){
        
    }
    public var frame:CGRect{
        return CGRect(x: getX(), y: getY(), width: getWidth(), height: getHeight())
    }
    
    public mutating func setlocation(width:PresentWidthType,height:PresentHeightType, x:PresentHLocationType,y:PresentVLocationType){
        self.widthType = width
        self.heightType = height
        self.hLocationType = x
        self.vLocationType = y
    }
    
    private func getWidth()->CGFloat{
        switch widthType {
        case .fullScreen:
            return UIScreen.main.bounds.width
        case .halfScreen:
            return UIScreen.main.bounds.width/2
        case .custom(let width):
            return width
        }
    }
    
    private func getHeight()->CGFloat{
        switch heightType {
        case .fullScreen:
            return UIScreen.main.bounds.height
        case .halfScreen:
            return UIScreen.main.bounds.height/2
        case .custom(let height):
            return height
        }
    }
    
    private func getX()->CGFloat{
        switch hLocationType {
        case .left:
            return 0
        case .center:
            return (UIScreen.main.bounds.width-getWidth())/2
        case .right:
            return UIScreen.main.bounds.width-getWidth()
        case .custom(let x):
            return x
        }
    }
    
    
   
        
       
        
         private func getY()->CGFloat{
            switch vLocationType {
            case .bottom:
                return UIScreen.main.bounds.height-getHeight()
            case .center:
                return (UIScreen.main.bounds.height-getHeight())/2
            case .top:
                return 0
            case .custom(let y):
                return y
            }
        }
        
        
    
    
    
}
