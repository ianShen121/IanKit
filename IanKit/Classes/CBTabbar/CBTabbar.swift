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
    var lineType:CBTabbarLineType = .nomal
    var lineColor:UIColor = UIColor.red
    var font:UIFont = UIFont.systemFont(ofSize: 14)
    
}

public enum CBTabbarStatus{
    case selected
    case normal
}

fileprivate let textId = "text"
fileprivate let imgeId = "image"
fileprivate let fix = "fix"

public class CBTabbar: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    public var selectedItemHanddler:((Int)->Void)?
    
    
    lazy var line:UIView = {
        let l = UIView()
        l.backgroundColor = self.configuration.lineColor
        return l
    }()
    
    public var items:[CBTabItmType] = []{
        didSet{
            menu.reloadData()
            if let cell = menu.cellForItem(at: IndexPath.init(item: selectedItem, section: 0)) {
                cell.isSelected = true
            }
//            menu.selectItem(at: IndexPath.init(item: selectedItem, section: 0), animated: false, scrollPosition: .centeredVertically)
            
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
        self.isLineAnimated = true
    }
    
    
    
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
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        menu.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
    }

    
 
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count

    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.items[indexPath.row]
        switch item {
        case .image(let imges):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imgeId, for: indexPath) as! CBTabBarImageItem
            cell.textColors = textColors
            
            cell.backGroundColors = backGroundColors
            cell.isItemSelected = indexPath.row == selectedItem
            cell.selectdHandder = { [weak self] (rect) in
                self?.layoutLine(rect)
            }
            cell.icon.image = imges
            return cell
        case .text(let texts):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: textId, for: indexPath) as! CBTabbarTextItem
            cell.textColors = textColors
            cell.labText.font = self.configuration.font
            cell.backGroundColors = backGroundColors
            cell.selectdHandder = { [weak self] (rect) in
                self?.layoutLine(rect)
            }
            cell.isItemSelected = indexPath.row == selectedItem
            cell.labText.text = texts
            return cell
        case .textAndImage(let obj):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fix, for: indexPath) as! CBTabbarImageAndTextItem
            cell.textColors = textColors
            cell.backGroundColors = backGroundColors
            cell.selectdHandder = { [weak self] (rect) in
                self?.layoutLine(rect)
            }
            cell.labText.font = self.configuration.font
            cell.isItemSelected = indexPath.row == selectedItem
            cell.labText.text = obj.text
            cell.icon.image = obj.image
            return cell
        case .textAndUrlImage(let obj):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fix, for: indexPath) as! CBTabbarImageAndTextItem
            cell.textColors = textColors
            cell.labText.font = self.configuration.font
            cell.backGroundColors = backGroundColors
            cell.selectdHandder = { [weak self] (rect) in
                self?.layoutLine(rect)
            }
            
            cell.isItemSelected = indexPath.row == selectedItem
            cell.labText.text = obj.0
            obj.imgeView?(cell.icon)
            return cell
        }
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
            return
        }
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
        v.register(CBTabbarTextItem.self, forCellWithReuseIdentifier: textId)
        v.register(CBTabBarImageItem.self, forCellWithReuseIdentifier: imgeId)
        v.register(CBTabbarImageAndTextItem.self, forCellWithReuseIdentifier: fix)
        return v
    }()
    
}
