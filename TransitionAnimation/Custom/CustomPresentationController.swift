//
//  CustomPresentationController.swift
//  TransitionAnimation
//
//  Created by Youngkook on 2016/11/16.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.modalPresentationStyle = .custom
    }
}

extension CustomPresentationController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if let isAnimated = transitionContext?.isAnimated , isAnimated == true {
            return 0.35
        } else {
            return 0
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromController = transitionContext.viewController(forKey: .from)
        let toController = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        
        var fromView: UIView?
        var toView: UIView?
        
        if transitionContext.responds(to: NSSelectorFromString("viewForKey:")) {
            fromView = transitionContext.view(forKey: .from)
            toView = transitionContext.view(forKey: .to)
        } else {
            fromView = fromController?.view
            toView = toController?.view
        }
        
        let isPresenting = self.presentingViewController == fromController
        
        var fromViewInitialFrame = transitionContext.initialFrame(for: fromController!)
        var fromViewFinalFrame = transitionContext.finalFrame(for: fromController!)
        
        var toViewInitialFrame = transitionContext.initialFrame(for: toController!)
        var toViewFinalFrame = transitionContext.finalFrame(for: toController!)
        
        if let toView = toView {
            containerView.addSubview(toView)
        }
        
        if isPresenting {
            
        } else {
            
        }
        fromView?.frame = transitionContext.initialFrame(for: fromController!)
        toView?.frame = transitionContext.finalFrame(for: toController!)
        fromView?.alpha = 1
        toView?.alpha = 0
        containerView.addSubview(toView!)
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveLinear, animations: {
            fromView?.alpha = 0
            toView!.alpha = 1
        }) { (isFinish) in
            if isFinish {
                let cancelled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!cancelled)
            }
        }

    }
}

extension CustomPresentationController: UIViewControllerTransitioningDelegate {
    
}
