//
//  ViewController.swift
//  Customer Profile
//
//  Created by RamKumar on 27/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    @IBOutlet weak var TaxExempt: UISwitch!
    @IBOutlet weak var Gender: UIButton!
    @IBOutlet weak var Notes: UITextField!
    @IBOutlet weak var Nationality: UITextField!
    @IBOutlet weak var CreditCard: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Address: UITextField!
    @IBOutlet weak var Mobile: UITextField!
    @IBOutlet weak var Birthday: UITextField!
    @IBOutlet weak var CustomerIdentityNumber: UITextField!
    @IBOutlet weak var LastName: UITextField!
    
    @IBOutlet weak var FirstName: UITextField!
    
  var CustomerData = Customer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func SaveButton(_ sender: Any) {
        CustomerData.FirstName = FirstName.text ?? ""
        CustomerData.Lastname = LastName.text ?? ""
        CustomerData.CustomerIdentityNumber = Int(CustomerIdentityNumber.text ?? "") ?? 0
        CustomerData.Birthday = Birthday.text ?? ""
        CustomerData.Mobile = Int(Mobile.text ?? "") ?? 0
        CustomerData.Address = Address.text ?? ""
        CustomerData.Email = Email.text ?? ""
        CustomerData.CreditCard = Int(CreditCard.text ?? "") ?? 0
        CustomerData.Nationality = Nationality.text ?? ""
        CustomerData.Notes = Notes.text ?? ""
        CustomerData.Gender = ""
        CustomerData.TaxExempt = TaxExempt.isOn
        
        print(CustomerData)
    }
    

}

