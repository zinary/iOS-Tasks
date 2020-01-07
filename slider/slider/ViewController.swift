//
//  ViewController.swift
//  slider
//
//  Created by Janakiraman Kanagaraj on 27/12/19.
//  Copyright © 2019 Benseron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var slidervalue:Int = 1
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var line: UIView!
    
    @IBOutlet weak var labelxconstraint: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        line.layer.cornerRadius = 5;
        line.layer.masksToBounds = true;
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func minus(_ sender: Any) {
          if slidervalue > 1
          {
        slidervalue-=1
       label.text = "\(slidervalue)"
            
            labelxconstraint.constant -= 25
        }
        
    }
    
    
    @IBAction func plus(_ sender: Any) {
        if slidervalue  > 0 && slidervalue < 10 {
            slidervalue+=1
        label.text = "\(slidervalue)"
             labelxconstraint.constant += 25
        }
    }
    
    
}

