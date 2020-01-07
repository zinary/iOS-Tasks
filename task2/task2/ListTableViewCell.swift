//
//  ListTableViewCell.swift
//  task2
//
//  Created by Janakiraman Kanagaraj on 03/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
  

    
    @IBOutlet weak var profileGender: UILabel!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileAge: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
