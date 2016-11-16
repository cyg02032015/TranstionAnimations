//
//  CustomSecondViewController.swift
//  TransitionAnimation
//
//  Created by Youngkook on 2016/11/16.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

class CustomSecondViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updatePreferredContentSizeWithTraitCollection(self.traitCollection)
    }
    
    @IBAction func unwindSegueDismissSecond(sender: UIStoryboardSegue) {}
    
    deinit {
        GGLog(message: "customFirst deinit")
    }
}

extension CustomSecondViewController {
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        self.updatePreferredContentSizeWithTraitCollection(newCollection)
    }
    
    fileprivate func updatePreferredContentSizeWithTraitCollection(_ collection: UITraitCollection) {
        self.preferredContentSize = CGSize(width: view.bounds.width, height: collection.verticalSizeClass == .compact ? 270 : 420)
        slider.maximumValue = Float(self.preferredContentSize.height)
        slider.minimumValue = Float(220)
        slider.value = slider.maximumValue
        GGLog(message: "preferredContentSize = \(self.preferredContentSize)")
    }
    
    @IBAction func slideChanged(_ sender: UISlider) {
        self.preferredContentSize = CGSize(width: view.bounds.width, height: CGFloat(sender.value))
    }
}
