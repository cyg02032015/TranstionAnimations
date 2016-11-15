//
//  SwipeSecondController.swift
//  TransitionAnimation
//
//  Created by Youngkook on 2016/11/14.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

private extension Selector {
    static let interactiveTransitionRecognizerAction = #selector(SwipeSecondController.interactiveTransitionRecognizerAction(_:))
}

class SwipeSecondController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        let interactiveTransitionRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: .interactiveTransitionRecognizerAction)
        interactiveTransitionRecognizer.edges = .left
        view.addGestureRecognizer(interactiveTransitionRecognizer)
    }
    
    func interactiveTransitionRecognizerAction(_ gesture: UIScreenEdgePanGestureRecognizer) {
        if gesture.state == .began {
            self.animationConfig(gesture)
        }
    }
    
    @IBAction func dismiss(_ sender: AnyObject) {
        self.animationConfig(sender)
    }
}

extension SwipeSecondController {
    /// fileprivate 文件内私有 而private是 类内或者结构体内私有 swift2.0的  private 对应 3.0的 fileprivate
    fileprivate func animationConfig(_ sender: AnyObject) {
        if let transitioningDelegate = self.transitioningDelegate as? SwipeTransitionDelegate {
            if sender.isKind(of: UIGestureRecognizer.self) {
                transitioningDelegate.gestureRecognizer = sender as! UIScreenEdgePanGestureRecognizer
            } else {
                transitioningDelegate.gestureRecognizer = nil
            }
            transitioningDelegate.targetEdge = .left
        }
        self.dismiss(animated: true, completion: nil)
    }

}
