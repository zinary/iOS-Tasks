//
//  ViewController.swift
//  URLSessionTableView
//
//  Created by RamKumar on 08/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    struct JsonType {
        var userId : Int
        var title : String
        var completed : boolean_t
//        init(userid:Int,title:String,completed:boolean_t) {
//            self.userId = userId
//             self.userId = userId
//             self.userId = userId
//
//        }
    }
    
    var tableData : [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func parseJSON(){
        
        guard let url = URL(string: "https://api.myjson.com/bins/vi56v") else{
            print("error in url")
            return
        }
        
        let Session = URLSession.shared.dataTask(with: url) { (data, response, error) in
        
      
            
            guard error == nil else{
                print("error")
                return
            }
            guard let data = data else{
                print("error in data")
                return
                
            }
            do{
                let jsonData = ( try JSONSerialization.jsonObject(with: data, options: [])) as? [String:Any]
                
                if let array = jsonData?["companies"] as? [String] {
                    self.tableData = array
                }
                print(self.tableData)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                }
            catch{
                print(error)
            }
            
           
        
        }
        
        Session.resume()
      }
  
    
    
}





extension ViewController :   UITableViewDelegate,UITableViewDataSource{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return  tableData.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuse", for: indexPath) as? TableViewCell
    cell?.cellLabel.text = tableData[indexPath.row]
  
    return cell!
    
}
}
