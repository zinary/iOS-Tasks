//
//  ViewController.swift
//  todo list
//
//  Created by Janakiraman Kanagaraj on 27/12/19.
//  Copyright © 2019 Benseron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var item : Item?

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isInAddMode = presentingViewController is UINavigationController
        
        if isInAddMode{
        dismiss(animated: true, completion: nil)
    }
        else{
            navigationController!.popViewController(animated: true)
            
        }
        
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let item = item {
            nameTextField.text = item.name
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue,sender : Any?){
        if sender as AnyObject? === saveButton{
            let name = nameTextField.text ??  ""
           item = Item(name: name)
        }
    
    }

}

