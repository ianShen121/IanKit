//
//  Presenter.swift
//  ISKit
//
//  Created by master on 2019/4/19.
//  Copyright © 2019 com.ian.pop. All rights reserved.
//

import Foundation
import UIKit


public let IanPresentHelper = Presenter.shared

public class Presenter:NSObject{
    
    fileprivate(set) var presentViewController:ISPresentationController?
    fileprivate var configuration:ISPresentConfiguration = ISPresentConfiguration()
    static let shared = Presenter()
    
    public override init() {
        
    }
    

     public func show(using presentedViewController:UIViewController,in presentingViewCotroller:UIViewController,config:ISPresentConfiguration=ISPresentConfiguration()){
        
        
        self.configuration = config
        let preVC = ISPresentationController.init(presentedViewController: presentedViewController, presenting: presentingViewCotroller)
        preVC.config = config
        self.presentViewController = preVC
        presentedViewController.transitioningDelegate = self
        presentingViewCotroller.present(presentedViewController, animated: true, completion: nil)
    }
    
    
    public func show(using presentedViewController:UIViewController,in presentingViewCotroller:UIViewController,configHannddler:(()->ISPresentConfiguration?)?){
        var config:ISPresentConfiguration!
        if configHannddler != nil && configHannddler!() != nil{
            config = configHannddler!()
        }else{
            config = ISPresentConfiguration()
        }
        self.show(using: presentedViewController, in: presentingViewCotroller, config: config)
    }

}


extension Presenter:UIViewControllerTransitioningDelegate{
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self.presentViewController
    }
    
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator.init(showType: .present, configuration: configuration)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animator.init(showType: .dismiss, configuration: configuration)
    }
    
    
    
}
