//
//  ViewController.swift
//  Star Rating
//
//  Created by Alexander Supe on 27.01.20.
//  Copyright © 2020 Alexander Supe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateRating(_ ratingControl: CustomControl) {
        if ratingControl.value == 1 {
            self.title = "User Rating: 1 star"
        } else {
            self.title = "User Rating: \(ratingControl.value) stars"
        }
    }
    
}

