//
//  CBTabbarTextItem.swift
//  SignPopView
//
//  Created by master on 2019/5/31.
//  Copyright © 2019 com.ian.mall. All rights reserved.
//

import UIKit

public class CBTabbarTextItem: CBTabbarItem {
    
    
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.status = .normal
        self.addSubview(labText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        labText.frame = self.bounds
    }
}
