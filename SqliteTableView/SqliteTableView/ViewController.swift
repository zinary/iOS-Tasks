//
//  ViewController.swift
//  SqliteTableView
//
//  Created by RamKumar on 23/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var update = false
    var userdata = User()
    var selectedUserData = User()
   
    @IBOutlet weak var deletebtn: UIButton!
    @IBOutlet weak var collegeTF: UITextField!
    @IBOutlet weak var deptTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        deletebtn.isHidden = false
        SQlite.shared.createTable()
        nameTF.text = selectedUserData.name
        deptTF.text = selectedUserData.department
        collegeTF.text = selectedUserData.college
    }
  
   
    @IBAction func deleteButton(_ sender: Any) {
        
        let id =  selectedUserData.id
        SQlite.shared.deleteDataFromTable(id: id)
        dismiss(animated: true, completion: nil)
       
    }
   
    @IBAction func saveButton(_ sender: Any) {
        userdata.name = nameTF.text!
        userdata.department = deptTF.text!
        userdata.college = collegeTF.text!
        if update == true
        {
         SQlite.shared.updateTable(user: userdata, id: selectedUserData.id)
            
        }
        else{
              SQlite.shared.addDatatoTable(userdata)
        }
         print(SQlite.shared.getDataFromTable())
    }
  
    @IBAction func closeButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}

