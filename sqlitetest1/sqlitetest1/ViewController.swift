//
//  ViewController.swift
//  SQLiteExample
//
//  Created by RamKumar on 20/01/20.
//  Copyright © 2020 Benseron. All rights reserved.

import UIKit
import SQLite3

class User{
    var id : Int
    var name : String
    var department : String
    
    init(id : Int,name : String,department : String) {
        self.id = id
        self.name=name
        self.department=department
    }
}

class ViewController: UIViewController {
    var userdetails = [User]()
    
    @IBOutlet weak var departmentTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    //    @IBOutlet weak var nameTextField: UITextField!
    
    //    @IBOutlet weak var departmentTextField: UITextField!
    var db : OpaquePointer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            let fileUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("userdata.sqlite")
            
            
            if sqlite3_open(fileUrl.path, &db) != SQLITE_OK{
                print("db connection error")
                return
            }
            
            let tableQuery = "CREATE TABLE IF NOT EXISTS userdata (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, department TEXT)"
            if  sqlite3_exec(db, tableQuery, nil, nil, nil) != SQLITE_OK{
                print("erron in table creation")
                return
            }
            print("table created")
            
        }
        catch{
            print("file error")
        }
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        let name = nameTextField.text
        
        let department = departmentTextField.text
        
        if (name?.isEmpty)!{
            print("empty name")
            return
        }
        
        
        if   (department?.isEmpty)!{
            print("empty dept")
            return
        }
        
        var stmt : OpaquePointer?
        
        let insertQuery  = "INSERT INTO userdata (name , department) VALUES (?,?)"
        
        if   sqlite3_prepare(db, insertQuery, -1, &stmt, nil) != SQLITE_OK{
            
            print("insert error")
        }
        
        if  sqlite3_bind_text(stmt, 1, name, -1, nil) != SQLITE_OK{
            print("err bind name")
        }
        if  sqlite3_bind_text(stmt, 2, department, -1, nil) != SQLITE_OK{
            print("err bind dpt")
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE{
            
            print("inserted")
            
            readvalues()
            
        }
        else{
            sqlite3_errmsg(stmt)
            print("not inserted")
        }
        
    }
    
    
    func readvalues(){
//        userdetails.removeAll()
        var stmt :OpaquePointer?
        let selectQuery = "SELECT * FROM userdata"
        
        if sqlite3_prepare(db, selectQuery, -1, &stmt, nil)  != SQLITE_OK{
            print("error selecting")
            return
            
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            
            let id = sqlite3_column_int(stmt, 0)
            let name =  sqlite3_column_text(stmt, 1)
            let department = sqlite3_column_text(stmt, 2)
            userdetails.append(User(id: Int(id), name: String(cString: name!), department: String(cString:department!) ))
            
        }
        for user in userdetails{
            print("\(user.name) : \(user.department) : \(user.id) ")
        }
        
        sqlite3_finalize(stmt)
        
    }
    
}
