//
//  ViewController.swift
//  AlamofireJSONinTableView
//
//  Created by RamKumar on 10/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit
import Alamofire

struct CountryData : Codable{
    let name : String
    let region : String
    let capital : String
    let population : Int
    let flag : String
}


class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuse", for: indexPath) as! CountryTableViewCell
        DispatchQueue.main.async {
             cell.tableLabel.text =  "\(indexPath.row+1). " + self.dataCountry[indexPath.row].name
           
        }
       
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "rowCell", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destionation = segue.destination as? DetailViewController
        {
            destionation.country = dataCountry[tableView.indexPathForSelectedRow!.row ]
        }
    }
    
    @IBOutlet weak var getCountriesButton :UIButton!
    @IBOutlet weak var tableView: UITableView!
    var dataCountry = [CountryData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
         tableView.reloadData()
        Alamofire.request("https://restcountries.eu/rest/v2/all").responseJSON { (response) in
            if let jsonData = response.data{
            
            do{
                self.dataCountry = try JSONDecoder().decode([CountryData].self, from: jsonData)

                for country in self.dataCountry{
                    print(country)
                }
            }
            catch{
                print(error.localizedDescription)
            }
            }
        }
        
        getCountriesButton?.layer.cornerRadius = 15
        
        
        
    }
    
    @IBAction func getButton(_ sender: Any) {
        tableView.reloadData()
    }


    
    
}

