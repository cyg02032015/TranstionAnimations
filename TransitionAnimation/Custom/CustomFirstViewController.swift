//
//  CustomFirstViewController.swift
//  TransitionAnimation
//
//  Created by Youngkook on 2016/11/16.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

class CustomFirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func goSecond(_ sender: AnyObject) {
        
        let second: CustomSecondViewController = self.storyboard!.instantiateViewController(withIdentifier: "CustomSecondViewController") as! CustomSecondViewController
            
        let customPresentationController = CustomPresentationController(presentedViewController: second, presenting: self)
        withExtendedLifetime(second) {
            second.transitioningDelegate = customPresentationController
            self.present(second, animated: true, completion: nil)
        }
    }
}
