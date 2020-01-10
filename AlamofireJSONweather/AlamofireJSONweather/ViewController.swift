//
//  ViewController.swift
//  AlamofireJSONweather
//
//  Created by RamKumar on 10/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//
import Foundation
import UIKit
import Alamofire


struct Weather : Decodable{
    let population : Int
    let name : String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    let weatherData = [Weather]()
    let url = "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22"
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request("https://restcountries.eu/rest/v2/all").responseJSON { (response) in
            
            if let jsonData = response.data {
                do {
                    let weatherData = try JSONDecoder().decode([Weather].self, from: jsonData)
                    self.textView.text = weatherData.description
                    for datas in weatherData{
                        print(datas.name + " : " + "population is \(datas.population)")
                    }
                }
                catch{
                    print(error)
                }
                
                
            }
            
            
         
        }
        
    }


}

