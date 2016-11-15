//
//  SwipeSecondController.swift
//  TransitionAnimation
//
//  Created by Youngkook on 2016/11/14.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

class SwipeSecondController: UIViewController {
    
    lazy var interactiveTransitionRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(SwipeSecondController.interactiveTransitionRecognizerAction(gesture:)))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        self.interactiveTransitionRecognizer.edges = .left
        view.addGestureRecognizer(interactiveTransitionRecognizer)
    }
    
    func interactiveTransitionRecognizerAction(gesture: UIScreenEdgePanGestureRecognizer) {
        if gesture.state == .began {
            self.animationConfig(gesture)
        }
    }
    
    private func animationConfig(_ sender: AnyObject) {
        if let transitioningDelegate = self.transitioningDelegate as? SwipeTransitionDelegate {
            if sender.isKind(of: UIGestureRecognizer.self) {
                transitioningDelegate.gestureRecognizer = interactiveTransitionRecognizer
            } else {
                transitioningDelegate.gestureRecognizer = nil
            }
            transitioningDelegate.targetEdge = .left
        }
        GGLog(message: "presenting = \(self.presentingViewController)")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismiss(_ sender: AnyObject) {
        self.animationConfig(sender)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
