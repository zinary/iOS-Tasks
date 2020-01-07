//
//  Item.swift
//  todo list
//
//  Created by Janakiraman Kanagaraj on 27/12/19.
//  Copyright © 2019 Benseron. All rights reserved.
//

import Foundation

class Item: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
    }
    
    static let Dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = Dir.appendingPathComponent("items")
    
    var name : String?
    init(name : String?) {
        self.name = name
        super.init()
    }
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        self.init(name: name)
    }
}
