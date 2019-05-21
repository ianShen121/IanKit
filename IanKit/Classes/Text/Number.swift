//
//  Number.swift
//  IanTextKit
//
//  Created by master on 2019/5/21.
//  Copyright © 2019 com.ian.mall. All rights reserved.
//

import Foundation
import UIKit
extension Int{
    public var string:String{
        return "\(self)"
    }
    
    public var double:Double{
        return Double(self)
    }
    
    public func toString(maxDigits:Int=2,minDigits:Int=0,roundingMode: NumberFormatter.RoundingMode = .floor)->String{
        let format = NumberFormatter()
        format.allowsFloats = true
        format.roundingMode = roundingMode
        format.maximumFractionDigits = maxDigits
        format.minimumFractionDigits = minDigits
        format.minimumIntegerDigits = 1
        let number = NSNumber.init(value: self)
        
        if let f = format.string(from: number) {
            return f
        }
        return "0"
    }
}


public extension Double{
    var string:String{
        return "\(self)"
    }
    
    func toString(maxDigits:Int=2,minDigits:Int=0,roundingMode: NumberFormatter.RoundingMode = .floor)->String{
        let format = NumberFormatter()
        format.allowsFloats = true
        format.roundingMode = roundingMode
        format.maximumFractionDigits = maxDigits
        format.minimumFractionDigits = minDigits
        format.minimumIntegerDigits = 1
        let number = NSNumber.init(value: self)
        
        if let f = format.string(from: number) {
            return f
        }
        return "0"
    }
}

public extension Float {
    var string:String{
        return "\(self)"
    }
    
    func toString(maxDigits:Int=2,minDigits:Int=0,roundingMode: NumberFormatter.RoundingMode = .floor)->String{
        let format = NumberFormatter()
        format.allowsFloats = true
        format.roundingMode = roundingMode
        format.maximumFractionDigits = maxDigits
        format.minimumFractionDigits = minDigits
        format.minimumIntegerDigits = 1
        let number = NSNumber.init(value: self)
        
        if let f = format.string(from: number) {
            return f
        }
        return "0"
    }
}
