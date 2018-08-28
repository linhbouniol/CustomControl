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
        switch ratingControl.value {
        case 1:
            navigationItem.title = "User Rating: \(ratingControl.value) star"
        default:
            navigationItem.title = "User Rating: \(ratingControl.value) stars"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

