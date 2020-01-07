//
//  ViewController.swift
//  task1
//
//  Created by Janakiraman Kanagaraj on 26/12/19.
//  Copyright © 2019 Benseron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var number : Int = 0
    
    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var bar: UIView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
       
        
    }
  
    
    @IBAction func minus(_ sender: Any) {
        var barpos = bar.frame.origin.x
        Label.frame.origin.x = barpos
        number -= 1
    Label.text = String(number)
    }
    
    @IBAction func plus(_ sender: Any) {
        number += 1
        Label.text = String(number)

    }
    
    
}

