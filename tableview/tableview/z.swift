//
//  VideoListScreen.swift
//  tableview
//
//  Created by Janakiraman Kanagaraj on 30/12/19.
//  Copyright © 2019 Benseron. All rights reserved.
//

import UIKit

class VideoListScreen: UITableViewController {
  
    
    
 var videos : [Video] = []
    override func viewDidLoad() {
        super.viewDidLoad()
  
       videos = createArray()
    }
    
    func createArray() -> [Video]{
        var tempVideo : [Video] = []
        var v:Video
//        for i in [1...10]{
            v = Video( title: "row")
            tempVideo.append(v)
//        }
       return tempVideo
    }
    

   override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video1 = videos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
        
        cell.setVideo(video:video1)
        return cell
    }
    



}
