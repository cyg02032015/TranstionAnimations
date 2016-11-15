//
//  SwipeViewController.swift
//  TransitionAnimation
//
//  Created by Youngkook on 2016/11/14.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController {
    lazy var second: SwipeSecondController = {
        return self.storyboard!.instantiateViewController(withIdentifier: "SwipeSecondController")
    }() as! SwipeSecondController
    lazy var customTransitionDelegate: SwipeTransitionDelegate = SwipeTransitionDelegate()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let interactiveTransitionRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(SwipeViewController.interactiveTransitionRecognizerAction(_:)))
        interactiveTransitionRecognizer.edges = .right
        self.view.addGestureRecognizer(interactiveTransitionRecognizer)
        self.second.transitioningDelegate = customTransitionDelegate
        self.second.modalPresentationStyle = .fullScreen
    }
    
    func interactiveTransitionRecognizerAction(_ gesture: UIScreenEdgePanGestureRecognizer) {
        if gesture.state == .began {
            self.animationConfig(gesture)
        }
    }
    
    func animationConfig(_ sender: AnyObject) {
        // 判断是点击按钮跳转还是手势跳转
        if sender.isKind(of: UIGestureRecognizer.self) {
            customTransitionDelegate.gestureRecognizer = sender as! UIScreenEdgePanGestureRecognizer
        } else {
            customTransitionDelegate.gestureRecognizer = nil
        }
        customTransitionDelegate.targetEdge = .right
        self.present(self.second, animated: true, completion: nil)
    }

    @IBAction func goSecond(_ sender: AnyObject) {
        self.animationConfig(sender)
    }

}
