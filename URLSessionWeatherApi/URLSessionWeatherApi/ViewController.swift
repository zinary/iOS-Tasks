//
//  ViewController.swift
//  URLSessionWeatherApi
//
//  Created by RamKumar on 09/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit
struct Weather : Codable{
    let id : Int
    let main : String
    let description:String
    
}

struct Coordinations : Codable{
    let lon : Double
    let lat : Double
}
struct WeatherType  : Codable{
    let coord : Coordinations
    let name : String
    let visibility : Int
    let weather : [Weather]
}

class ViewController: UIViewController {

    
    var JsonData : [WeatherType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        guard let url = URL(string: "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22") else {
            print("error in url")
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) {(data,response,error) in
                do{
                    self.JsonData = [try JSONDecoder().decode(WeatherType.self, from: data!)]
                    print(self.JsonData)
                }
                catch{
                    print("error in json \(error.localizedDescription)")
            }
                
            }.resume()
            
            
            
        }
        
    }




