//
//  ViewController.swift
//  AlamofirewithGit
//
//  Created by RamKumar on 14/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      guard  let url = URL(string: "https://restcountries.eu/rest/v2/all") else {return}
        Alamofire.request(url, method:.post, parameters: "api_dev_key=391be4fd2cac31c2114eb8f467d21cc7&api_option=paste&api_paste_code=\(pastebinTextField.text ?? "no text added")", encoding: UTF-8 , headers: bod)
        }
        
        
            
        }







