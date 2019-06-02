//
//  CBTabbarItem.swift
//  SignPopView
//
//  Created by 谌志伟 on 2019/5/31.
//  Copyright © 2019 com.ian.mall. All rights reserved.
//

import UIKit

public class CBTabbarItem: UICollectionViewCell {
    
    public var selectdHandder:((CGRect)->Void)?
    lazy var labText:UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 14)
        return l
    }()
    
    var textColors:[CBTabbarStatus:UIColor] = [.normal:UIColor.black,.selected:UIColor.red]
    
    var backGroundColors:[CBTabbarStatus:UIColor] = [.normal:UIColor.white,.selected:UIColor.white]
    
    var status:CBTabbarStatus = .normal {
        didSet{
            if let textColor = textColors[status]{
                labText.textColor = textColor
            }
            if let bgColor = backGroundColors[status]{
                self.backgroundColor = bgColor
            }
        }
        
    }
    
    var isItemSelected:Bool = false {
        didSet{
            self.status = self.isItemSelected ? .selected : .normal
            if self.isItemSelected{
                self.selectdHandder?(self.frame)
            }
        }
        
    }
    
  
    
    
    
    
}
