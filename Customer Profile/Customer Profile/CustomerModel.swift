//
//  CustomerModel.swift
//  Customer Profile
//
//  Created by RamKumar on 28/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import Foundation
struct Customer {
    var id : Int
    var FirstName : String
    var Lastname : String
    var CustomerIdentityNumber : Int32
    var Birthday : String
    var Mobile : Int32
    var Email : String
    var Address : String
    var CreditCard : Int32
    var Gender : String
    var Nationality : String
    var Notes : String
    var TaxExempt : Int
    
    init() {
        id = 0
        FirstName = ""
        Lastname = ""
        CustomerIdentityNumber = 0
        Birthday = ""
        Mobile = 0
        Email = ""
        Address = ""
        CreditCard = 0
        Gender = ""
        Nationality = ""
        Notes = ""
        TaxExempt = 0
    }
    
}
