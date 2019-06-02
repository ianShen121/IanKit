//
//  CBTabbarImgeAndTextItem.swift
//  SignPopView
//
//  Created by master on 2019/5/31.
//  Copyright © 2019 com.ian.mall. All rights reserved.
//

import UIKit

class CBTabbarImageAndTextItem: CBTabbarItem {
    lazy var icon:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.status = .normal
        self.addSubview(icon)
        self.addSubview(labText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let textHeight = self.bounds.height/3
        let imgeHeight = self.bounds.height-textHeight - 5
        labText.frame = CGRect.init(x: 0, y: self.bounds.height-textHeight-5, width: self.bounds.width, height: textHeight)
        icon.frame = CGRect.init(x: self.bounds.width/2-imgeHeight/2, y: 0, width: imgeHeight, height: imgeHeight)
    }
}
