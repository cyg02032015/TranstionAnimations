//
//  SwipeTransitionController.swift
//  TransitionAnimation
//
//  Created by Youngkook on 2016/11/15.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

class SwipeTransitionController: UIPercentDrivenInteractiveTransition {
    var edge: UIRectEdge
    var gestureRecognizer: UIScreenEdgePanGestureRecognizer
    var transitionContext: UIViewControllerContextTransitioning? = nil
    init(gesture: UIScreenEdgePanGestureRecognizer, edge: UIRectEdge) {
        assert(edge == .top || edge == .bottom ||
            edge == .left || edge == .right,
               "edgeForDragging must be one of UIRectEdgeTop, UIRectEdgeBottom, UIRectEdgeLeft, or UIRectEdgeRight.")
        self.edge = edge
        self.gestureRecognizer = gesture
        super.init()
        self.gestureRecognizer.addTarget(self, action: #selector(SwipeTransitionController.gestureRecognizeDidUpdate(gesture:)))
    }
    
    func percentForGesture(gesture: UIScreenEdgePanGestureRecognizer) -> CGFloat {
        let containerView = self.transitionContext?.containerView
        let locationInView = gesture.location(in: containerView)
        guard let width = containerView?.frame.width, let height = containerView?.frame.height else {
            GGLog(message: "width or height is nil")
            return 0
        }
        switch self.edge {
        case UIRectEdge.right: return (width - locationInView.x) / width
        case UIRectEdge.left: return locationInView.x / width
        case UIRectEdge.top: return locationInView.y / height
        case UIRectEdge.bottom: return (height - locationInView.y) / height
        default: return 0
        }
    }
    
    deinit {
        self.gestureRecognizer.removeTarget(self, action: #selector(SwipeTransitionController.gestureRecognizeDidUpdate(gesture:)))
    }
}

extension SwipeTransitionController {
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        super.startInteractiveTransition(transitionContext)
    }
    
    func gestureRecognizeDidUpdate(gesture: UIScreenEdgePanGestureRecognizer) {
        switch gesture.state {
        case .began: break
        case .changed:  self.update(self.percentForGesture(gesture: gesture))
        case .ended:
            if self.percentForGesture(gesture: gesture) > 0.5 {
                self.finish()
            } else {
                self.cancel()
            }
        default: self.cancel()
            
        }
    }
}

