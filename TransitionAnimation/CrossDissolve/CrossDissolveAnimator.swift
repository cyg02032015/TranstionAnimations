//
//  CrossDissolveAnimator.swift
//  TransitionAnimation
//
//  Created by Youngkook on 2016/11/11.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

class CrossDissolveAnimator: NSObject {
    
}

extension CrossDissolveAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromController = transitionContext.viewController(forKey: .from)
        let toController = transitionContext.viewController(forKey: .to)
        let containerView = transitionContext.containerView
        
        var fromView = fromController?.view
        var toView = toController?.view
        
        if transitionContext.responds(to: NSSelectorFromString("viewForKey:")) {
            fromView = transitionContext.view(forKey: .from)
            toView = transitionContext.view(forKey: .to)
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

public func GGLogContext(context: UIViewControllerContextTransitioning?) {
    guard let context = context else {
        GGLog(message: "UIViewControllerContextTransitioning is nil")
        return
    }
    GGLog(message:
//        "contianerView = \(context.containerView)\n" +
        "\n++++++++++++++++++++++++++++++++++++++++++\n\n" +
        "\nisAnimated = \(context.isAnimated)\n" +
        "isInteractive = \(context.isInteractive)\n" +
        "transitionWasCancelled = \(context.transitionWasCancelled)\n" +
        "presentationStyle = \(context.presentationStyle)\n" +
        "targetTransform = \(context.targetTransform)" +
        "\n++++++++++++++++++++++++++++++++++++++++++\n\n")
}
