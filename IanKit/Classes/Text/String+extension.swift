//
//  String+extension.swift
//  IanTextKit
//
//  Created by master on 2019/5/20.
//  Copyright © 2019 com.ian.mall. All rights reserved.
//

import Foundation
import UIKit



public extension String{
    var int:Int{
        return Int(self) ?? 0
    }
    
    var double:Double{
        return Double(self) ?? 0
    }
    
    var float:Float{
            return Float(self) ?? 0
    }
    
    var rnb:String{
        return "¥\(self)"
    }
    
    func toNumber(maxDigits:Int=2,minDigits:Int=0,roundingMode: NumberFormatter.RoundingMode = .floor)->String{
        let format = NumberFormatter()
 
        format.roundingMode = roundingMode
        format.maximumFractionDigits = maxDigits
        format.minimumFractionDigits = minDigits
        format.minimumIntegerDigits = 1
        
        format.numberStyle = .none
        
        if let number = format.number(from: self) ,let dealed = format.string(from: number){
            return dealed
        }
        return "0"
    }
    
    

    
}





//MARK:-SubString
public extension String {
    
     var trim:String{
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    
    subscript (r: Range<Int>) -> String {
        get {
            if (r.lowerBound > count) || (r.upperBound > count) { return "截取超出范围" }
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }

    func sub(to end: Int) ->String{
        
        if !(end < self.count) { return "截取超出范围" }
        let sInde = index(startIndex, offsetBy: end)
        return String(self[...sInde])
    }
    
    func sub(from start: Int) -> String {
        if !(start < count) { return "截取超出范围" }
        let sRang = index(startIndex, offsetBy: start)
        //return substring(with: sRang)
        return String(self[sRang...])
    }
    
    func insert(content: String,locat: Int) -> String {
        if !(locat < count) { return "截取超出范围" }
        let str1 = sub(to: locat)
        let str2 = sub(from: locat+1)
        return str1 + content + str2
    }
    
    
    func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }

    
    func ranges(of string: String) -> [NSRange] {
        var rangeArray = [NSRange]()
        var searchedRange: Range<String.Index>
        guard let sr = self.range(of: self) else {
            return rangeArray
        }
        searchedRange = sr
        
        var resultRange = self.range(of: string, options: .regularExpression, range: searchedRange, locale: nil)
        while let range = resultRange {
            let nsrange = NSRange.init(location: self.distance(from: self.startIndex, to: range.lowerBound), length: string.count)
            rangeArray.append(nsrange)
            searchedRange = Range(uncheckedBounds: (range.upperBound, searchedRange.upperBound))
            resultRange = self.range(of: string, options: .regularExpression, range: searchedRange, locale: nil)
        }
        return rangeArray
    }
    
    
    
    
}
