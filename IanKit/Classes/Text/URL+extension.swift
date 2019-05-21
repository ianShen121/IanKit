//
//  URL+extension.swift
//  IanTextKit
//
//  Created by master on 2019/5/21.
//  Copyright © 2019 com.ian.mall. All rights reserved.
//

import Foundation

public extension URL{
    
    
    

    
    var hostName:[String]{
        get{
            return self.absoluteString.getSubstring(.custom("://(.*?):|://(.*?)/")).compactMap({$0.replacingOccurrences(of: "://", with: "").replacingOccurrences(of: ":", with: "").replacingOccurrences(of: "/", with: "")})
        }
    }
    
    
    var port:[String]{
        get{
           return  self.absoluteString.getSubstring(.custom(      ":\\d{1,4}")).compactMap({$0.replacingOccurrences(of: ":", with: "")})
        }
    }
    
    var httpProtocol:[String]{
        get{
            return self.absoluteString.getSubstring(.custom("(.*?)://")).compactMap { (t) -> String? in
                return t.replacingOccurrences(of: "://", with: "")
            }
        }
    }
}
