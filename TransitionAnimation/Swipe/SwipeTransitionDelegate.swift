//
//  SwipeTransitionDelegate.swift
//  TransitionAnimation
//
//  Created by Youngkook on 2016/11/15.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

class SwipeTransitionDelegate: NSObject {
    var targetEdge: UIRectEdge!
    var gestureRecognizer: UIScreenEdgePanGestureRecognizer!
}

extension SwipeTransitionDelegate: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SwipeTransitionAnimator(targetEdge: self.targetEdge)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SwipeTransitionAnimator(targetEdge: self.targetEdge)
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if self.gestureRecognizer != nil {
            return SwipeTransitionController(gesture: self.gestureRecognizer, edge: self.targetEdge)
        } else {
            return nil
        }
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if self.gestureRecognizer != nil {
            return SwipeTransitionController(gesture: self.gestureRecognizer, edge: self.targetEdge)
        } else {
            return nil
        }
    }
}
