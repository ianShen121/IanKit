//
//  CBTabbarItem.swift
//  SignPopView
//
//  Created by 谌志伟 on 2019/5/31.
//  Copyright © 2019 com.ian.mall. All rights reserved.
//

import UIKit

public class CBTabbarItem: UICollectionViewCell {
    
    var item:CBTabItmType = .text(""){
        didSet{
            switch item {
            case .text(let text):
                labText.text = text
            case .image(let img):
                icon.image = img
            case .textAndImage(let obj):
                icon.image = obj.image
                labText.text = obj.text
            case .textAndUrlImage(let obj):
                obj.imgeView?(self.icon)
                labText.text = obj.0
            }
            
            
            
        }
    }
    
    var badgeSizeType:BadgeSizeType = .auto{
        didSet{
            
            self.setNeedsLayout()
        }
    }
    
    var imageSizeType:ImageSizeType = .auto{
        didSet{
            self.setNeedsLayout()
        }
    }
    
    public var selectdHandder:((CGRect)->Void)?
    lazy var labText:UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 14)
        return l
    }()
    
    lazy var labBadge:UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = UIColor.white
        l.layer.masksToBounds = true
        return l
    }()
    
    lazy var icon:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    
    var badgeItem:BadgeValueItem?{
        didSet{
            let value = badgeItem?.value ?? 0
            labBadge.isHidden = value == 0
            labBadge.text = "\(value)"
            
        }
    }
    
    
    
    var badgeColor:UIColor = UIColor.red{
        didSet{
            labBadge.backgroundColor = badgeColor
        }
    }
    
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
    
  
    public override init(frame: CGRect) {
        super.init(frame: frame)
        labBadge.isHidden = (badgeItem?.value ?? 0) == 0
        labBadge.backgroundColor = badgeColor
        self.status = .normal
        self.addSubview(labText)
        self.addSubview(icon)
        self.addSubview(labBadge)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        

   
        
        switch self.item {
        case .image(_):
            
            switch self.imageSizeType{
            case .auto:
                icon.frame = self.bounds
            case .custom(let size):
                icon.frame = CGRect.init(x: self.bounds.width/2-size.width/2, y: self.bounds.height/2-size.height/2, width: size.width, height: size.height)
            }
            
           
        case .text(_):
           labText.frame = self.bounds
        default:
            let textHeight = self.bounds.height/3
            let imgeHeight = self.bounds.height-textHeight - 5
            labText.frame = CGRect.init(x: 0, y: self.bounds.height-textHeight-5, width: self.bounds.width, height: textHeight)
            
            switch imageSizeType{
            case .auto:
                icon.frame = CGRect.init(x: self.bounds.width/2-imgeHeight/2, y: 0, width: imgeHeight, height: imgeHeight)
            case .custom(let size):
                let w = self.bounds.width < size.width ? self.bounds.width : size.width
                let h = imgeHeight < size.height ? imgeHeight : size.height
                icon.frame = CGRect.init(x: self.bounds.width/2-w/2, y: imgeHeight/2-h/2, width: w, height: h)
                
            }
            
        }
      
        switch self.badgeSizeType {
        case .custom(let rect):
            self.labBadge.frame = rect
            self.labBadge.layer.cornerRadius = rect.height/2
        case .sizeCustom(let size):
            self.labBadge.frame = CGRect.init(x: self.bounds.width-size.width-5, y: 5, width: size.width, height: size.height)
            self.labBadge.layer.cornerRadius = size.height/2
        default:
            let size = self.bounds.width/3
            self.labBadge.frame = CGRect.init(x: self.bounds.width-size - 5, y: 5, width: size, height: size)
            self.labBadge.layer.cornerRadius = size/2
            
        }
      
        
        
        
    }
    
    
}
