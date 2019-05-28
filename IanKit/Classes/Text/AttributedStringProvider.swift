//
//  AttributedStringProvider.swift
//  IanTextKit
//
//  Created by master on 2019/5/17.
//  Copyright © 2019 com.ian.mall. All rights reserved.
//

import Foundation
import UIKit


public enum AttributedRangType{
    case all
    case custom(range:NSRange)
    case firstSubstring(str:String)
    case lastSubstring(str:String)
    case substring(str:String)
    case besides(str:String)
}


public struct AttributedStringProvider {
    private var string:String = ""
    public var mutableAttributed:NSMutableAttributedString!

    //init
    public func attributedString(_ attributedTypes:[AttributedType])->NSAttributedString{
        let values = attributedTypes.flatMap({$0.attributes})
        var dics:[NSAttributedString.Key:Any] = [:]
        values.forEach { (dic) in
            dics.updateValue(dic.value, forKey: dic.key)
        }
        return NSAttributedString.init(string: string, attributes: dics)
    }
    

    
    public func appendAttributes(_ attributs:[AttributedType],rangeType:AttributedRangType = .all)->AttributedStringProvider{
        
        let ranges = self.getRange(rangType: rangeType)
        ranges.forEach { (r) in
            attributs.forEach { (type) in
                self.mutableAttributed.appendAttribute(attribute: type, in: r)
            }
        }
        return self
    }
    
    public func appendAtrribute(_ attribute:AttributedType,rangeType:AttributedRangType = .all)->AttributedStringProvider{
        let rangeType = getRange(rangType: rangeType)
        rangeType.forEach { (r) in
            self.mutableAttributed.appendAttribute(attribute: attribute, in: r)
        }
        return self
    }
    
    ///get rang with rangeType
    private func getRange(rangType:AttributedRangType)->[NSRange]{
        switch rangType {
        case .all:
            return [NSRange.init(location: 0, length:mutableAttributed.length)]
        case .custom(let range):
            return [range]
        case .firstSubstring(let sub):
            var resRange = NSRange.init(location: 0, length: 0)
            let str = mutableAttributed.string
            guard str.contains(sub) else {return [resRange]}
            if let r = self.mutableAttributed.string.range(of: sub, options: .literal, range: nil, locale: nil) {
               resRange.location = str.distance(from: str.startIndex, to: r.lowerBound)
               resRange.length = sub.count
            }
            return [resRange]
        case .lastSubstring(let sub):
            var resRange = NSRange.init(location: 0, length: 0)
            
            let str = mutableAttributed.string
            guard str.contains(sub) else {return [resRange]}
            if let r = self.mutableAttributed.string.range(of: sub, options: .backwards, range: nil, locale: nil) {
                resRange.location = str.distance(from: str.startIndex, to: r.lowerBound)
                resRange.length = sub.count
            }
            return [resRange]
        case .substring(let sub):
            return mutableAttributed.string.ranges(of: sub)
        case .besides(let bstr):
            let str = self.mutableAttributed.string
            
            var resRanges:[NSRange] =  []
            let rsStrings = str.components(separatedBy: bstr).noRepeat
            for st  in rsStrings {
                resRanges += str.ranges(of: st)
            }
            
            return resRanges
        }
    }
    
    
    init(str:String) {
        self.string = str
        self.mutableAttributed = NSMutableAttributedString.init(string: str)
    }
}



public extension String {
    var cb:AttributedStringProvider{
        return AttributedStringProvider.init(str: self)
    }
}



extension NSMutableAttributedString {
    
    func appendAttribute(attribute:AttributedType,in range:NSRange){
        self.addAttributes(attribute.attributes, range: range)
    }
    
    
    
    
}
