//
//  ViewController.swift
//  URLSessionWithJSONdecode
//
//  Created by RamKumar on 09/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//


struct Country : Codable{
    let name : String
    let capital : String
    let region : String
    let population : Int
    let timezones : [String]
    let nativeName : String
}

import UIKit
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var getDataButton: UIButton!
    

    var FinalData = [Country]()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
      
        guard  let url = URL(string: "https://restcountries.eu/rest/v2/all") else {return}
    let task = URLSession.shared
        task.dataTask(with: url) { (data, response, error) in
            
        do{
             self.FinalData = try JSONDecoder().decode([Country].self, from: data!)
        }
        catch{
            print("error in json")
        }

    }.resume()
        
    }
    
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FinalData.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuse", for: indexPath) as! TableViewCell
        
        cell.nameLabel.text = FinalData[indexPath.row].name
        cell.capitalLabel.text = FinalData[indexPath.row].capital
        cell.regionLabel.text = FinalData[indexPath.row].region
        cell.timeZoneLabel.text = FinalData[indexPath.row].timezones[0]
        cell.nativeNameLabel.text = FinalData[indexPath.row].nativeName
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let alertbox = UIAlertController(title: "alert", message: "Population of \(FinalData[indexPath.row].name) is \(FinalData[indexPath.row].population)", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "close", style: .cancel, handler: nil)
        alertbox.addAction(alertAction)
       present(alertbox,animated: true,completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func getButton(_ sender: Any) {
       
       self.tableView.reloadData()
       getDataButton.isHidden = true
        
    }
    }



