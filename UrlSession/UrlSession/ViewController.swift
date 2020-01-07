//
//  ViewController.swift
//  UrlSession
//
//  Created by Janakiraman Kanagaraj on 07/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    let apiService = WeatherAPIService()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
@IBAction func getButton(_ sender: Any) {
    let url = URL(string: "https://samples.openweathermap.org/data/2.5/weather?zip=94040,us&appid=b6907d289e10d714a6e88b30761fae22")
    apiService.executeWebRequest(urlToExecute: url!) { (responseDict, error) in
        DispatchQueue.main.async {
            if let unwrappedError = error{
                print(unwrappedError.localizedDescription)
            }
            self.textView.text = responseDict?.description
        }
        
    }


}
}
