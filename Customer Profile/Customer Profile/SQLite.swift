//
//  SQlite.swift
//  SqliteTableView
//
//  Created by RamKumar on 23/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit
import SQLite3

class SQlite {
    
    static let shared = SQlite()
    //create db
    func getSQliteDatabase() -> String {
        
        do{
            let fileUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("customerdata").appendingPathExtension("sqlite")
            return fileUrl.path
        }
        catch let error{
            print("error opening datebase \(error.localizedDescription)")
            return "err"
        }
    }
    
    //opens db
    
    func openDatabase() -> OpaquePointer? {
        let path = getSQliteDatabase()
        var openDB : OpaquePointer? = nil
        
        if sqlite3_open(path, &openDB) == SQLITE_OK{
            print("opening successfull")
        }
        else{
            print(sqlite3_errmsg(openDB))
        }
        return openDB
    }
    
    
    //create table
    func createTable()  {
        let tableQuery = "CREATE TABLE IF NOT EXISTS customer2 (id INTEGER PRIMARY KEY AUTOINCREMENT,FIRSTNAME TEXT,LASTNAME TEXT, CUSTOMERID BIGINT ,BIRTHDAY TEXT , MOBILE BIGINT, EMAIL TEXT, ADDRESS TEXT , CREDITCARD BIGINT , GENDER TEXT , NATIONALITY TEXT , NOTES TEXT , TAXEXEMPT INTEGER)"
        var createTableDB : OpaquePointer? = nil
        let db = openDatabase()
        
        if sqlite3_prepare_v2(db, tableQuery , -1, &createTableDB, nil) == SQLITE_OK
        {
            
            if sqlite3_step(createTableDB) == SQLITE_DONE {
                print("table created successfully")
            }
            else{
                NSLog("%s , error in table creation",sqlite3_errmsg(db!))
            }
        }
            
        else{
            NSLog("%s , error in create query prepare",sqlite3_errmsg(db!))
        }
        
        sqlite3_finalize(createTableDB)
        sqlite3_close(db)
    }
    
    
    //insert data to table
    
    func addDatatoTable(_ details : Customer)  {
        print(details)
        let insertTableQuery = "REPLACE INTO customer2 (FIRSTNAME ,LASTNAME , CUSTOMERID  ,BIRTHDAY  , MOBILE , EMAIL , ADDRESS  , CREDITCARD  , GENDER  , NATIONALITY  , NOTES  , TAXEXEMPT) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)"
        var addDataDB : OpaquePointer? = nil
        let db = openDatabase()
        
        if sqlite3_prepare_v2(db, insertTableQuery, -1, &addDataDB, nil) == SQLITE_OK{
            sqlite3_bind_text(addDataDB, 1,(details.FirstName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(addDataDB, 2,(details.Lastname as NSString).utf8String, -1, nil)
            sqlite3_bind_int(addDataDB, 3, Int32(details.CustomerIdentityNumber))
            sqlite3_bind_text(addDataDB, 4, (details.Birthday as NSString).utf8String, -1, nil)
            sqlite3_bind_int(addDataDB, 5, Int32(details.Mobile))
            sqlite3_bind_text(addDataDB, 6, (details.Email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(addDataDB, 7, (details.Address as NSString).utf8String, -1, nil)
            sqlite3_bind_int(addDataDB, 8, Int32(details.CreditCard))
            sqlite3_bind_text(addDataDB, 9, (details.Gender as NSString).utf8String, -1, nil)
            sqlite3_bind_text(addDataDB, 10, (details.Nationality as NSString).utf8String, -1, nil)
            sqlite3_bind_text(addDataDB, 11, (details.Notes as NSString).utf8String, -1, nil)
            sqlite3_bind_int(addDataDB, 12, Int32(details.TaxExempt))
    
            if sqlite3_step(addDataDB)==SQLITE_DONE{
                print("insertion successful")
            }
            else{
                NSLog("%s, insert error", sqlite3_errmsg(db))
            }
            
        }
        else{
            NSLog("%s , error in add query prepare",sqlite3_errmsg(db))
        }
        sqlite3_finalize(addDataDB)
        sqlite3_close(db)
        
    }
    
    //get data from table
    
    func getDataFromTable() -> [Customer] {
        let getQuery = " select * from customer2"
        let db = openDatabase()
        var getDataDB : OpaquePointer?
        var customers : [Customer] = []
        
        if sqlite3_prepare_v2(db, getQuery, -1, &getDataDB, nil) == SQLITE_OK{
            
            while(sqlite3_step(getDataDB)==SQLITE_ROW){
                var customer = Customer()
                customer.id = Int(sqlite3_column_int(getDataDB, 0))
                customer.FirstName = String(cString: sqlite3_column_text(getDataDB, 1))
                customer.Lastname = String(cString: sqlite3_column_text(getDataDB, 2))
                customer.CustomerIdentityNumber = Int32(sqlite3_column_int(getDataDB, 3))
                customer.Birthday = String(cString: sqlite3_column_text(getDataDB, 4))
                customer.Mobile = Int32(sqlite3_column_int(getDataDB, 5))
                customer.Email = String(cString:sqlite3_column_text(getDataDB, 6) )
                customer.Address = String(cString: sqlite3_column_text(getDataDB, 7))
                customer.CreditCard = Int32(sqlite3_column_int(getDataDB, 8))
                customer.Gender = String(cString: sqlite3_column_text(getDataDB, 9))
                customer.Nationality = String(cString: sqlite3_column_text(getDataDB, 10))
                customer.Notes = String(cString: sqlite3_column_text(getDataDB, 11))
                customer.TaxExempt = Int(sqlite3_column_int(getDataDB, 12))
                customers.append(customer)
                
            }
        }
            
        else{
            NSLog("%s error   preparing get query ", sqlite3_errmsg(db))
        }
        
        sqlite3_finalize(getDataDB)
        sqlite3_close(db)
        
        return customers
    }
    
//    func updateTable( user: User ,id : Int)  {
//        let updateQuery = "update userdata3 set name = '\(user.name)' , department = '\(user.department)' , college = '\(user.college)' where id = '\(id)'"+
//        var updateQueryDb : OpaquePointer?
//        
//        let db = openDatabase()
//        
//        if sqlite3_prepare_v2(db, updateQuery, -1, &updateQueryDb, nil) == SQLITE_OK{
//            
//            if sqlite3_step(updateQueryDb) == SQLITE_DONE{
//                print("updated '\(user.name)' ")
//            }
//            else{
//                NSLog("%s update error", sqlite3_errmsg(db))
//            }
//        }else{
//            NSLog("%s update prepare error", sqlite3_errmsg(db))
//        }
//        sqlite3_finalize(updateQueryDb)
//        sqlite3_close(db)
//        
//    }
    
    func deleteDataFromTable(id:Int)  {
        let deleteQuery = "delete from customer2 where id = '\(id)'"
        var deleteDb : OpaquePointer?
        let db = openDatabase()
        
        if sqlite3_prepare_v2(db, deleteQuery, -1, &deleteDb, nil) == SQLITE_OK {
            if sqlite3_step(deleteDb) == SQLITE_DONE{
                print("deleted")
            }
            else{
                NSLog("%s delete error", sqlite3_errmsg(db))
            }
        }
        else{
            NSLog("%s delete prepare error", sqlite3_errmsg(db))
        }
        
        sqlite3_finalize(deleteDb)
        sqlite3_close(db)
        
    }
    
}
