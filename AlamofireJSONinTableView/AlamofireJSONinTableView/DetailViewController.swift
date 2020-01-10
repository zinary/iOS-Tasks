//
//  DetailViewController.swift
//  AlamofireJSONinTableView
//
//  Created by RamKumar on 10/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit
import WebKit
class DetailViewController: UIViewController {
    @IBOutlet weak var RegionLabel: UILabel!
    
    @IBOutlet weak var PopulationLabel: UILabel!
    @IBOutlet weak var CapitalLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    
    var country : CountryData?
    
    override func viewDidLoad() {
    
        
        super.viewDidLoad()
        
        guard let url = URL(string: country?.flag ?? "no data") else {return}
        let request = URLRequest(url: url)
        RegionLabel.text = "Region : " + (country?.region ?? "No data")
        CapitalLabel.text = "Capital : " + (country?.capital ?? "No data")
        PopulationLabel.text = "Population : \(country?.population ?? 0)"
        
        DispatchQueue.main.async {
            self.webView.load(request)
        }
      
        
       
    }
    


    
}
