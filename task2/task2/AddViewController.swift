//
//  AddViewController.swift
//  task2
//
//  Created by Janakiraman Kanagaraj on 03/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit

protocol AddTask {
    func addTask(name: String,age:Int,gender:String)
}

class AddViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var genderText: UITextField!
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let x = ageText.text?.rangeOfCharacter(from: NSCharacterSet.decimalDigits) ? true : false
//          return x
//    }
    
    func invalidAge(customMessage:String){
        let alertController = UIAlertController(title: "Alert", message: customMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Close", style: .cancel , handler: nil )
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    @IBAction func saveButton(_ sender: Any) {
        
        if nameText.text! != ""  && ageText.text! != ""  && genderText.text! != ""{
//            let x : Int?
//            x = Int((ageText?.text!)!)
//            if x != nil  {
            guard let ageCheck = Int(ageText.text!) else{
                invalidAge(customMessage: "Enter Valid age")
                return
                
            }
            if ageCheck <= 100 && ageCheck >= 6{
                    delegate?.addTask(name: nameText.text!, age: Int(ageCheck) , gender: genderText.text!)
                navigationController?.popViewController(animated: true)
            }
            else {
             invalidAge(customMessage: "Age must be greater than 6 and less than 100")
            }
            }
        
        else {
            let alertController = UIAlertController(title: "Alert", message: "Enter all the Details to save", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Close", style: .cancel, handler: nil )
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
        }
        }

    var delegate : AddTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        ageText.delegate = self
        saveButton.layer.cornerRadius = 15
    }
}
