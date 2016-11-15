//
//  SwipeTransitionAnimator.swift
//  TransitionAnimation
//
//  Created by Youngkook on 2016/11/15.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

class SwipeTransitionAnimator: NSObject {
    var targetEdge: UIRectEdge!
    
    init(targetEdge: UIRectEdge) {
        self.targetEdge = targetEdge
    }
}

extension SwipeTransitionAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
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
        
        let isPresenting = toController?.presentingViewController == fromController
        let fromFrame = transitionContext.initialFrame(for: fromController!)
        let toFrame = transitionContext.finalFrame(for: toController!)
        
        var offset: CGVector!
        if self.targetEdge == .left {
            offset = CGVector(dx: 1, dy: 0)
        } else if self.targetEdge == .right {
            offset = CGVector(dx: -1, dy: 0)
        } else if self.targetEdge == .top {
            offset = CGVector(dx: 0, dy: 1)
        } else if self.targetEdge == .bottom {
            offset = CGVector(dx: 0, dy: -1)
        } else {
            assert(false, "targetEdge must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.")
        }
        
        if isPresenting {
            fromView?.frame = fromFrame
            toView?.frame = toFrame.offsetBy(dx: toFrame.size.width * offset.dx * -1, dy: toFrame.size.height * offset.dy * -1)
            containerView.addSubview(toView!)
        } else {
            fromView?.frame = fromFrame
            toView?.frame = toFrame
            containerView.insertSubview(toView!, belowSubview: fromView!)
        }
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: { 
            if isPresenting {
                toView?.frame = toFrame
            } else {
                fromView?.frame = fromFrame.offsetBy(dx: fromFrame.size.width * offset.dx, dy: fromFrame.size.height * offset.dy)
            }
        }) { (finish: Bool) in
            let wasCancelled = transitionContext.transitionWasCancelled
            if wasCancelled {
                toView?.removeFromSuperview()
            }
            transitionContext.completeTransition(!wasCancelled)
        }
    }
}
