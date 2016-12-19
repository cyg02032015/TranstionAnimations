//
//  SecondViewController.swift
//  TransitionAnimation
//
//  Created by Youngkook on 2016/12/19.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imgView: UIImageView!
    var percentDrivenTransition: UIPercentDrivenInteractiveTransition!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(SecondViewController.edgePanGestureRecognizer(_:)))
        gesture.edges = .left
        view.addGestureRecognizer(gesture)
    }
    
    func edgePanGestureRecognizer(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        let progress = gestureRecognizer.translation(in: self.view).x / self.view.bounds.size.width
        if gestureRecognizer.state == .began {
            self.percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            _ = self.navigationController?.popViewController(animated: true)
        } else if gestureRecognizer.state == .changed {
            self.percentDrivenTransition.update(progress)
        } else if gestureRecognizer.state == .cancelled || gestureRecognizer.state == .ended {
            if progress > 0.5 {
                self.percentDrivenTransition.finish()
            } else {
                self.percentDrivenTransition.cancel()
            }
            self.percentDrivenTransition = nil
        }
    }
}

extension SecondViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if toVC.isKind(of: CollectionViewController.self) {
            return MoveToFirstAnimator()
        } else {
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if animationController.isKind(of: MoveToFirstAnimator.self) {
            return self.percentDrivenTransition
        } else {
            return nil
        }
    }
}
