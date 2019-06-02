//
//  CBTabbarController.swift
//  SignPopView
//
//  Created by 谌志伟 on 2019/5/31.
//  Copyright © 2019 com.ian.mall. All rights reserved.
//

import UIKit

fileprivate var CBTabbarKey = "CBTABBARKEY"





class CBTabbarController: UIViewController,UIScrollViewDelegate {

    lazy var tabbar:CBTabbar = {
       let t = CBTabbar.init()
        t.selectedItemHanddler = { [weak self] (idx) in
            self?.setViewHiddel(current: self!.selectedViewController, next: idx)
            self?.selectedViewController = idx
            self?.setShowingVC()
            self?.setContentOffset(animated: true)
        }
        return t
    }()
    
   
    
    init(vcs:[UIViewController],selectedViewController:Int=0) {
        super.init(nibName: nil, bundle: nil)
        self.viewcontrollers = vcs
        self.selectedViewController = selectedViewController
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate(set) var viewcontrollers:[UIViewController] = []
    
    fileprivate(set) var matchViewController:[[Int:UIViewController]] = []
    
    lazy var scrollView:UIScrollView = {
       let v = UIScrollView()
        v.delegate = self
        v.isPagingEnabled = true
        return v
    }()
    
    var selectedViewController = 0
    
    
    func setContentOffset(animated:Bool){
        guard selectedViewController < self.matchViewController.count else {
            return
        }
        let matches = matchViewController[selectedViewController]
        for (k,_) in matches{
            if k == selectedViewController{
                self.scrollView.setContentOffset(CGPoint.init(x: CGFloat(k)*self.view.frame.width, y: 0), animated: animated)
            }
        }
    }
    
    
    func setShowingVC(){
        let matches = matchViewController[selectedViewController]
        for (k,v) in matches{
            if k == selectedViewController{
                if !self.children.contains(v){
                  
                    self.addChild(v)
                    v.view.frame = CGRect.init(x: CGFloat(k)*self.view.frame.width, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - 90)
                    self.scrollView.addSubview(v.view)
                }
                
            }
        }
        
        
        
    }
    

    
    func setViewHiddel(current:Int,next:Int){
        self.matchViewController.forEach { (dic) in
            for (k,v) in dic {
                if k == current || k == next{
                    v.view.isHidden = false
                }else{
                    v.view.isHidden = true
                }
            }
        }
    }
    

    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let page = Int(targetContentOffset.move().x/self.view.bounds.width)
        setViewHiddel(current: selectedViewController, next: page)
        self.selectedViewController = page
        self.setShowingVC()
        tabbar.setSelectedItem(idx: page, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    }
    
    func setUI(){
        tabbar.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: 90)
        scrollView.frame = CGRect.init(x: 0, y: 90, width: self.view.bounds.width, height:self.view.bounds.height-90)
        self.view.addSubview(tabbar)
        self.view.addSubview(scrollView)
        tabbar.items = viewcontrollers.map({$0.cbTabType})
        
        self.scrollView.contentSize = CGSize.init(width: CGFloat(viewcontrollers.count)*self.view.bounds.width, height: 0)
        for (idx,vc) in viewcontrollers.enumerated(){
            let dic = [idx:vc]
            matchViewController.append(dic)
        }
        
        setShowingVC()
        setContentOffset(animated: false)
        tabbar.setSelectedItem(idx: selectedViewController, animated: false)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

public extension UIViewController{
    var cbTabType:CBTabItmType{
        get{
            return objc_getAssociatedObject(self, &CBTabbarKey) as? CBTabItmType ?? .text("")
        }
        set{
            objc_setAssociatedObject(self, &CBTabbarKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}