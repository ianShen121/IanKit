//
//  Array+extention.swift
//  IanTextKit
//
//  Created by master on 2019/5/21.
//  Copyright © 2019 com.ian.mall. All rights reserved.
//

import Foundation

public extension Array where Element:Hashable {
    public var noRepeat:[Element]{
        var set = Set<Element>(self)
        var resultArray = [Element]()
        
        for item in self {
            if set.contains(item){
                resultArray.append(item)
                set.remove(item)
            }
        }
        return resultArray
    }
    
    
}
