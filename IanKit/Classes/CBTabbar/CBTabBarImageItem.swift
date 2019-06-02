//
//  CBTabBarImageItem.swift
//  SignPopView
//
//  Created by master on 2019/5/31.
//  Copyright © 2019 com.ian.mall. All rights reserved.
//

import UIKit

class CBTabBarImageItem: CBTabbarItem {
    lazy var icon:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(icon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        icon.frame = self.bounds
    }
}
