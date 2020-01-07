//
//  VideoCell.swift
//  tableview
//
//  Created by Janakiraman Kanagaraj on 30/12/19.
//  Copyright © 2019 Benseron. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var videoImageView: UIImageView!
    
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    func setVideo(video:Video){
        videoTitleLabel.text = video.title
    }

}
