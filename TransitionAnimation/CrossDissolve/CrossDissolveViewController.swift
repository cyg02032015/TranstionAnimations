//
//  CrossDissolveViewController.swift
//  TransitionAnimation
//
//  Created by Youngkook on 2016/11/11.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

class CrossDissolveViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
    }
    @IBAction func toSecondViewController(sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CrossSecondViewController") else {
            GGLog(message: "second viewcontroller is nil")
            return
        }
        vc.modalPresentationStyle = .fullScreen
        vc.transitioningDelegate = self
        self.present(vc, animated: true) { }
    }
}

extension CrossDissolveViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        GGLog(message: "=====================\n present \npresented = \(presented)\n presenting = \(presenting)\n sourceVC = \(source)")
        return CrossDissolveAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        GGLog(message: "=====================\n dismissed \n dismissed = \(dismissed)\n")
        return CrossDissolveAnimator()
    }
}
