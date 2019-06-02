//
//  CBTabbar.swift
//  SignPopView
//
//  Created by master on 2019/5/31.
//  Copyright © 2019 com.ian.mall. All rights reserved.
//

import UIKit


public enum CBTabbarLineType {
    case hidden
    case custom(width:CGFloat)
    case nomal
}



public enum CBTabItmType{
    case text(_ t:String)
    case image(_ img:UIImage)
    case textAndImage(_ obj:(text:String,image:UIImage))
    case textAndUrlImage(_ text:String,imgeView:((UIImageView)->Void)?)
}

public enum ItemSizeType{
    case auto
    case custom(_ height:CGFloat)
}


public struct CBTabbarConfiguration {
    public var lineType:CBTabbarLineType = .nomal
    public var lineColor:UIColor = UIColor.red
    public var font:UIFont = UIFont.systemFont(ofSize: 14)
    public var badgeColor:UIColor = UIColor.red
    public var badgeFont:UIFont = UIFont.boldSystemFont(ofSize: 14)
}

public enum CBTabbarStatus{
    case selected
    case normal
}


public class BadgeValueItem {
    public var value = 0
    public var index = 0
}



public class CBTabbar: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    public var selectedItemHanddler:((Int)->Void)?
    
    
    lazy var line:UIView = {
        let l = UIView()
        l.backgroundColor = self.configuration.lineColor
        return l
    }()
    
    public var items:[CBTabItmType] = []{
        didSet{

            for i in 0..<items.count{
                let it = BadgeValueItem()
                it.index = i
                badgeValues.append(it)
            }
            
            menu.reloadData()
        }
    }
    
    public var configuration:CBTabbarConfiguration = CBTabbarConfiguration()
    
    public var minItemWidth:CGFloat = 60
    
    fileprivate var lineHeight:CGFloat{
        get{
            switch self.lineWidthType {
            case .hidden:
                return 0
            default:
                return 2
            }
        }
    }
    
    var isLineAnimated = true
    
    private(set) var selectedItem:Int = 0{
        didSet{
            
       
            
          menu.reloadData()
        }
    }
    
    public func setSelectedItem(idx:Int,animated:Bool){
        self.isLineAnimated = animated
        selectedItem = idx
        
    }
    
    var badgeValues:[BadgeValueItem] = []
    
    public var itemSizeType:ItemSizeType = .auto
    
    public var lineWidthType:CBTabbarLineType = .nomal
    
    var textColors:[CBTabbarStatus:UIColor] = [.normal:UIColor.black,.selected:UIColor.red]
    
    var backGroundColors:[CBTabbarStatus:UIColor] = [.normal:UIColor.white,.selected:UIColor.white]
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    //--init ui
    private func setUI(){
        self.addSubview(menu)
        self.menu.addSubview(line)
        
        
        
    }
    
    func setItemTextColor(color:UIColor,for status:CBTabbarStatus){
        textColors.updateValue(color, forKey: status)
        
    }
    
    func setItemBackgroudColor(color:UIColor,for status:CBTabbarStatus){
        backGroundColors.updateValue(color, forKey: status)
        
    }
    
    
    
    //MARK:-- setBadge
    public func setBadge(value:Int,ad idx:Int){
        
        for bgitem in badgeValues{
            if bgitem.index == idx {
                bgitem.value = value
                break
            }
        }
        
//        let set = NSMutableSet()
//        let idx = NSIndexPath.init(row: idx, section: 0)
//        set.add(idx)
//        let idxn = set as IndexSet
        menu.reloadData()
        
        
        
       
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        menu.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
    }

    
 
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count

    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.items[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CBTabbarItem
        cell.selectdHandder = { [weak self] (rect) in
            self?.layoutLine(rect)
        }
        
        
        cell.badgeItem = badgeValues[indexPath.row]
        cell.item = item
        cell.textColors = textColors
        cell.badgeColor = configuration.badgeColor
        cell.backGroundColors = backGroundColors
        cell.isItemSelected = indexPath.row == selectedItem
        
        
        return cell
        
      
    }
    
    func layoutLine(_ rect:CGRect){
        let contentSize = self.menu.contentSize
 
        let sw = UIScreen.main.bounds.width
        if rect.midX > sw/2 && contentSize.width-rect.midX > sw/2 {
            menu.setContentOffset(CGPoint.init(x: -(sw/2 - rect.midX), y: 0), animated: true)
        }
        var lineWidth = rect.width
        switch self.lineWidthType {
        case .custom(let w):
            lineWidth = lineWidth < w ? lineWidth : w
        default:
            break
        }
        guard isLineAnimated else {
             self.line.frame = CGRect.init(x:rect.minX + (rect.width-lineWidth)/2, y: self.menu.bounds.height-self.lineHeight, width: lineWidth, height: self.lineHeight)
            self.isLineAnimated = true
            return
        }
        self.isLineAnimated = true
        UIView.animate(withDuration: 0.2) {
              self.line.frame = CGRect.init(x:rect.minX + (rect.width-lineWidth)/2, y: self.menu.bounds.height-self.lineHeight, width: lineWidth, height: self.lineHeight)
        }
      
        
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = indexPath.row
        
        self.selectedItemHanddler?(selectedItem)

    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
       
        let height = self.bounds.height-lineHeight
        switch self.itemSizeType {
        case .auto:
            let autoWidth = self.bounds.width/CGFloat(self.items.count)
            let width = autoWidth > minItemWidth ? autoWidth : minItemWidth
            return CGSize.init(width: width, height: height)
        case .custom(let h):
            return CGSize.init(width: h, height: height)
        }
    }

    
    
    lazy var menu:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let v = UICollectionView.init(frame: CGRect.zero, collectionViewLayout:layout )
        v.delegate = self
        v.showsHorizontalScrollIndicator = false
        v.dataSource = self
        v.backgroundColor = UIColor.white
   
       
        v.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom:self.lineHeight, right: 0)
        v.register(CBTabbarItem.self, forCellWithReuseIdentifier: "cell")
    
        return v
    }()
    
}
