//
//  ViewController.swift
//  UserDefaultsTest
//
//  Created by RamKumar on 16/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var storedText: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let savedText = UserDefaults.standard.object(forKey: "nameText")
        if let savedtext = savedText as? String{
            storedText.text = "Stored Name : " + savedtext
        }
    }

    @IBAction func savebutton(_ sender: Any) {
        
        UserDefaults.standard.set(nameTextField.text, forKey: "nameText")
        print(UserDefaults.standard.dictionaryRepresentation())
        
        let savedText = UserDefaults.standard.object(forKey: "nameText")
        if let savedtext = savedText as? String{
             storedText.text = "Stored Name : " + savedtext
        }
        
        
    }
    @IBAction func deleteButton(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "nameText")
        print(UserDefaults.standard.dictionaryRepresentation())
       storedText.text = ""
    }
    
}

