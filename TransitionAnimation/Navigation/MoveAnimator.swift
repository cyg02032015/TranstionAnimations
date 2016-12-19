//
//  MoveAnimator.swift
//  TransitionAnimation
//
//  Created by Youngkook on 2016/12/19.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

class MoveAnimator: NSObject {
    
}

extension MoveAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        guard let fromVC = transitionContext.viewController(forKey: .from) as? CollectionViewController else {
            return
        }
        guard let toVC = transitionContext.viewController(forKey: .to) as? SecondViewController else {
            return
        }
        // 获取collectionView被点击的indexPath
        guard let indexPath = fromVC.collectionView.indexPathsForSelectedItems?.first else {
            return
        }
        fromVC.indexPath = indexPath
        let cell = fromVC.collectionView.cellForItem(at: indexPath) as! CustomCell
        let snapShotView = cell.imgView.snapshotView(afterScreenUpdates: false) // get snapShot
        // 将rect从view中转换到当前视图中，返回在当前视图中的rect
        snapShotView?.frame = container.convert(cell.imgView.frame, from: cell.imgView.superview)
        fromVC.finalCellRect = snapShotView?.frame
        cell.imgView.isHidden = true
        
        //设置第二个控制器的位置、透明度、
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toVC.view.alpha = 0
        toVC.imgView.isHidden = true
        
        //把动画前后的两个ViewController加到容器中
        container.addSubview(toVC.view)
        container.addSubview(snapShotView!)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            container.layoutIfNeeded()
                toVC.view.alpha = 1.0
                snapShotView?.frame = container.convert(toVC.imgView.frame, from: toVC.imgView.superview)
        }) { (finished:Bool) in
                toVC.imgView.isHidden = false
                cell.imgView.isHidden = false
                snapShotView?.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
