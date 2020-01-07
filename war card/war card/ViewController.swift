//
//  ViewController.swift
//  war card
//
//  Created by Janakiraman Kanagaraj on 26/12/19.
//  Copyright © 2019 Benseron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var x = 1
    @IBOutlet weak var LeftCardView: UIImageView!
    
    
    @IBOutlet weak var RightCardView: UIImageView!
    
    
    @IBOutlet weak var PlayerScore: UILabel!
    
    
    @IBOutlet weak var CpuScore: UILabel!
    @IBOutlet weak var TIE: UILabel!
    
    var LeftScore = 0
    var RightScore = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        TIE.text = ("")
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func DealButton(_ sender: Any) {
        let LeftNumber = Int.random(in: 2...14)
        let RightNumber = Int.random(in: 2...14)
                print("button pressed ")
        LeftCardView.image = UIImage(named: "card\(LeftNumber)")
        RightCardView.image = UIImage(named: "card\(RightNumber)")
        if LeftNumber > RightNumber{
            LeftScore += 1
            PlayerScore.text = String(LeftScore)
            TIE.text = ("")
            
        }
        else if RightNumber > LeftNumber{
            RightScore += 1
            CpuScore.text = String(RightScore)
            TIE.text = ("")
        }
        
        else{
            print("tie")
            TIE.text = ("Tie")
        }
    
    

}
}
