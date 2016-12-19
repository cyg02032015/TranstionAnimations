//
//  MoveToFirstAnimator.swift
//  TransitionAnimation
//
//  Created by Youngkook on 2016/12/19.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

class MoveToFirstAnimator: NSObject {

}

extension MoveToFirstAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        guard let fromVC = transitionContext.viewController(forKey: .from) as? SecondViewController else {
            return
        }
        guard let toVC = transitionContext.viewController(forKey: .to) as? CollectionViewController else {
            return
        }
        
        let snapShotView = fromVC.imgView.snapshotView(afterScreenUpdates: false)
        snapShotView?.frame = container.convert(fromVC.imgView.frame, from: fromVC.imgView.superview)
        fromVC.imgView.isHidden = true
        
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        
        guard let cell = toVC.collectionView.cellForItem(at: toVC.indexPath!) as? CustomCell else { return  }
        cell.imgView.isHidden = true
        container.insertSubview(toVC.view, belowSubview: fromVC.view)
        container.addSubview(snapShotView!)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: { 
                fromVC.view.alpha = 0
            snapShotView?.frame = toVC.finalCellRect!
        }) { (finished:Bool) in
            snapShotView?.removeFromSuperview()
            fromVC.imgView.isHidden = false
            cell.imgView.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
}
