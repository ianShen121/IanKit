//
//  Animator.swift
//  ISKit
//
//  Created by master on 2019/4/18.
//  Copyright © 2019 com.ian.pop. All rights reserved.
//

import UIKit
import Foundation

class Animator:NSObject,UIViewControllerAnimatedTransitioning {
    
    var showType:ShowType = .present
    
    var config:ISPresentConfiguration = ISPresentConfiguration()
    init(showType:ShowType,configuration:ISPresentConfiguration) {
        super.init()
        self.config = configuration
        
        self.showType = showType
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch config.animateType {
        case .normal:
            normalAnimate(using: transitionContext)
        case .scale(let factor):
            scaleAnimate(using: transitionContext, factor: factor)
        }
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return config.animateDuration
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        
    }
    
}

extension Animator{
    fileprivate func scaleAnimate(using transitionContext: UIViewControllerContextTransitioning,factor:CGFloat){
        let presentedKey:UITransitionContextViewControllerKey = self.showType == .present ? .to : .from
        guard let presentedVC = transitionContext.viewController(forKey: presentedKey) else {return}
        let containerView = transitionContext.containerView
        
        let isPresentation = presentedKey == .to
        
        presentedVC.view.frame = transitionContext.finalFrame(for: presentedVC)
        
        containerView.addSubview(presentedVC.view)
        if isPresentation{
                presentedVC.view.transform = CGAffineTransform.init(scaleX: factor, y: factor)
        }
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            presentedVC.view.transform = CGAffineTransform.identity
        }) { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        
        
    }
}


//MARK:--NoralType
extension Animator{
    fileprivate func normalAnimate(using transitionContext: UIViewControllerContextTransitioning){
        let presentedKey:UITransitionContextViewControllerKey = self.showType == .present ? .to : .from
        guard let presentedVC = transitionContext.viewController(forKey: presentedKey) else {return}
        let containerView = transitionContext.containerView
        
        let isPresentation = presentedKey == .to
        let presentedVCFrame = transitionContext.finalFrame(for: presentedVC)
        let dismissFrame = self.frameOfPresentedVCWhenHidden(from: presentedVCFrame, ctx: transitionContext)
        
        let inisitalFrame = isPresentation ? dismissFrame : presentedVCFrame
        let finalFrame = isPresentation ? presentedVCFrame : dismissFrame
        presentedVC.view.frame = inisitalFrame
        
        containerView.addSubview(presentedVC.view)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            presentedVC.view.frame = finalFrame
        }) { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    private func frameOfPresentedVCWhenHidden(from presentedFrame:CGRect,ctx:UIViewControllerContextTransitioning)->CGRect{
        var dismissedFrame: CGRect = presentedFrame
        switch config.direction {
        case .fromLeft:
            dismissedFrame.origin.x = -presentedFrame.width
        case .fromRight:
            dismissedFrame.origin.x = ctx.containerView.frame.size.width
        case .fromTop:
            dismissedFrame.origin.y = -presentedFrame.height
        case .fromBottom:
            dismissedFrame.origin.y = ctx.containerView.frame.size.height
        default:break
        }
        return dismissedFrame
        
    }
    
    
    
}



//Present
extension Animator{
//   calc frame before animation begin

    
    
    
}


