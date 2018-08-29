//
//  ViewController.swift
//  Custom UIControl
//
//  Created by Linh Bouniol on 8/28/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func updateRating(_ ratingControl: CustomControl) {
        if ratingControl.value == 1 {
            self.title = "User Rating: \(ratingControl.value) star"
        } else {
            self.title = "User Rating: \(ratingControl.value) stars"
        }
        
        NSLog("New Rating: \(ratingControl.value)")
    }
    
    // Test out how different actions work when hooked up to different events in the storyboard
//    @IBAction func touchUpInside(_ ratingControl: CustomControl) {
//        NSLog("Touch Up In: \(ratingControl.value)")
//    }
    
//    @IBAction func touchUpOutside(_ ratingControl: CustomControl) {
//        NSLog("Touch Up Out: \(ratingControl.value)")
//    }
    
//    @IBAction func dragInside(_ ratingControl: CustomControl) {
//        NSLog("Drag In: \(ratingControl.value)")
//    }
    
//    @IBAction func dragOutside(_ ratingControl: CustomControl) {
//        NSLog("Drag Out: \(ratingControl.value)")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

