//
//  UsersDataModel.swift
//  SqliteTableView
//
//  Created by RamKumar on 23/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit

struct User {
    var id : Int
    var name : String
    var department : String
    var college : String
    init() {
 
         name = ""
         department = ""
         college = ""
         id = Int()
    }
}
