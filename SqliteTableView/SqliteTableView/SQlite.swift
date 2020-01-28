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
             let fileUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("userdata").appendingPathExtension("sqlite")
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
        let tableQuery = "CREATE TABLE IF NOT EXISTS userdata3(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,department TEXT, college TEXT)"
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
    
    func addDatatoTable(_ details : User)  {
        print(details)
        let insertTableQuery = "REPLACE INTO userdata3 (name,department,college) VALUES (?,?,?)"
        var addDataDB : OpaquePointer? = nil
        let db = openDatabase()
        
        if sqlite3_prepare_v2(db, insertTableQuery, -1, &addDataDB, nil) == SQLITE_OK{
            
            sqlite3_bind_text(addDataDB, 1,(details.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(addDataDB, 2,(details.department as NSString).utf8String, -1, nil)
            sqlite3_bind_text(addDataDB, 3,(details.college as NSString).utf8String, -1, nil)
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
    
    func getDataFromTable() -> [User] {
        let getQuery = " select * from userdata3"
        let db = openDatabase()
        var getDataDB : OpaquePointer?
        var users : [User] = []
        
        if sqlite3_prepare_v2(db, getQuery, -1, &getDataDB, nil) == SQLITE_OK{
            
            while(sqlite3_step(getDataDB)==SQLITE_ROW){
                var user = User()
                user.id = Int(sqlite3_column_int(getDataDB, 0))
                user.name = String(cString: sqlite3_column_text(getDataDB, 1))
                user.department = String(cString: sqlite3_column_text(getDataDB, 2))
                user.college = String(cString: sqlite3_column_text(getDataDB, 3))
                
                users.append(user)
                
            }
        }
        
        else{
            NSLog("%s error   preparing get query ", sqlite3_errmsg(db))
        }
        
        sqlite3_finalize(getDataDB)
        sqlite3_close(db)
        
        return users
    }
    
    func updateTable( user: User ,id : Int)  {
        let updateQuery = "update userdata3 set name = '\(user.name)' , department = '\(user.department)' , college = '\(user.college)' where id = '\(id)'"
        var updateQueryDb : OpaquePointer?
        
        let db = openDatabase()
        
        if sqlite3_prepare_v2(db, updateQuery, -1, &updateQueryDb, nil) == SQLITE_OK{
            
            if sqlite3_step(updateQueryDb) == SQLITE_DONE{
                print("updated '\(user.name)' ")
            }
            else{
                NSLog("%s update error", sqlite3_errmsg(db))
            }
        }else{
            NSLog("%s update prepare error", sqlite3_errmsg(db))
        }
        sqlite3_finalize(updateQueryDb)
        sqlite3_close(db)
        
    }
    
    func deleteDataFromTable(id:Int)  {
        let deleteQuery = "delete from userdata3 where id = '\(id)'"
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
