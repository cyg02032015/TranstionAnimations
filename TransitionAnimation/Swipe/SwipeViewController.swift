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
    lazy var interactiveTransitionRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(SwipeViewController.interactiveTransitionRecognizerAction(_:)))
    lazy var customTransitionDelegate: SwipeTransitionDelegate = SwipeTransitionDelegate()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        interactiveTransitionRecognizer.edges = .right
        view.addGestureRecognizer(interactiveTransitionRecognizer)
        self.second.transitioningDelegate = customTransitionDelegate
        self.second.modalPresentationStyle = .fullScreen
    }
    
    func interactiveTransitionRecognizerAction(_ gesture: UIScreenEdgePanGestureRecognizer) {
        if gesture.state == .began {
            self.animationConfig(gesture)
        }
    }
    
    func animationConfig(_ sender: AnyObject) {
        if sender.isKind(of: UIGestureRecognizer.self) {
            customTransitionDelegate.gestureRecognizer = interactiveTransitionRecognizer
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
