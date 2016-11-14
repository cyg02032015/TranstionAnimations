//
//  SwipeViewController.swift
//  TransitionAnimation
//
//  Created by Youngkook on 2016/11/14.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func goSecond(_ sender: AnyObject) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SwipeSecondController")
        self.present(vc!, animated: true, completion: nil)
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
