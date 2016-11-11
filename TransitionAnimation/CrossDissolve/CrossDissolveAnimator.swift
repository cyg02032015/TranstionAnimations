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
        GGLog(message: "transitionDuration = \(GGLogContext(context: transitionContext))")
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        GGLog(message: "transitionDuration = \(GGLogContext(context: transitionContext))")
    }
}

public func GGLogContext(context: UIViewControllerContextTransitioning?) {
    guard let context = context else {
        GGLog(message: "UIViewControllerContextTransitioning is nil")
        return
    }
    GGLog(message:
        "contianerView = \(context.containerView)\n" +
        "isAnimated = \(context.isAnimated)\n" +
        "isInteractive = \(context.isInteractive)\n" +
        "transitionWasCancelled = \(context.transitionWasCancelled)\n" +
        "presentationStyle = \(context.presentationStyle)\n" +
        "targetTransform = \(context.targetTransform)")
}
