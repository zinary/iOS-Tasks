//
//  CustomerModel.swift
//  Customer Profile
//
//  Created by RamKumar on 28/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import Foundation
struct Customer {
    var FirstName : String
    var Lastname : String
    var CustomerIdentityNumber : Int
    var Birthday : String
    var Mobile : Int
    var Email : String
    var Address : String
    var CreditCard : Int
    var Gender : String
    var Nationality : String
    var Notes : String
    var TaxExempt : Bool
    
    init() {
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
        TaxExempt = false
    }
    
}
