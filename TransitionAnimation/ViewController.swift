//
//  ViewController.swift
//  TransitionAnimation
//
//  Created by Youngkook on 2016/11/7.
//  Copyright © 2016年 Youngkook. All rights reserved.
//

import UIKit
var s = "-"
var isMinus: Bool = false
public func GGLog<T>(message : T, file : String = #file, lineNumber : Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("[\(fileName):line:\(lineNumber)]- \(s)\(message)")
    #endif
}

class ViewController: UITableViewController {
    
    @IBAction func unwindMenu(segue: UIStoryboardSegue) {
        
    }
}

