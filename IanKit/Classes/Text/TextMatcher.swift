//
//  TextMatcher.swift
//  IanTextKit
//
//  Created by master on 2019/5/21.
//  Copyright © 2019 com.ian.mall. All rights reserved.
//

import Foundation

public enum TextPatternType{
    case mobileInCN
    case postCodeCN
    case email
    case chinese
    case ipv4
    case ipv6
    case url
    case idCardCN
    case custom(_ pattern:String)
    var pattern:String{
        switch self {
        case .custom(let pattern):
            return pattern
        case .email:
            return "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$"
        case .chinese:
            return "^[\\u4e00-\\u9fa5]{0,}$"
        case .mobileInCN:
            return "^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|16[0|1|2|3|5|6|7|8|9]|17[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9]|19[0|1|2|3|5|6|7|8|9]|)\\d{8}$"
        case .postCodeCN:
            return "[1-9]\\d{5}(?!\\d)"
        case .ipv4:
            return "^(25[0-5]|2[0-4]\\d|[0-1]?\\d?\\d)(\\.(25[0-5]|2[0-4]\\d|[0-1]?\\d?\\d)){3}$"
        case .ipv6:
            return "/^(([\\da-fA-F]{1,4}):){8}$/"
        case .url:
            return "(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]"
        case .idCardCN:
            return "/(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)/"
        }
    }
    
}

public extension String{
    //Match is the text illegal
    public func match(_ type:TextPatternType)->Bool{
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", type.pattern)
        return predicate.evaluate(with: self)
    }
    
    
    //get substrings whitch match pattern
    
    public func getSubstring( _ type:TextPatternType)->[String]{
        let pattern = type.pattern
        var res:[String] = []
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return res
        }
        let matchResult = regex.matches(in: self, options: [], range: NSRange.init(location: 0, length: self.count))
        
        for results in matchResult {
            
            let range = results.range
            let s = self[range.location..<(range.location + range.length)]
            res.append(s)
        }
        return res
    }
    
    
    public func getRanges(_ type:TextPatternType)->[NSRange]{
        let pattern = type.pattern
        var res:[NSRange] = []
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return res
        }
        let matchResult = regex.matches(in: self, options: [], range: NSRange.init(location: 0, length: self.count))
        res = matchResult.map({$0.range})
        return res
    }
    
    
    
    
}
