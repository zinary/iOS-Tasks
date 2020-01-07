//
//  ViewController.swift
//  URLSessionWithGETandPost
//
//  Created by Janakiraman Kanagaraj on 07/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pastebinTextField: UITextField!
    @IBOutlet weak var pastebinurl: UILabel!
    
    @IBOutlet weak var chuckTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pastebinurl.isHidden = true
        
        
    }

    @IBAction func ChuckButton(_ sender: Any) {
        
        guard  let url = URL(string: "https://api.chucknorris.io/jokes/random") else {
            fatalError("error getting data from the api")
            
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data{
                do{
                	let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dict = json as? [String:Any]{
                           if let value = dict["value"] as? String
                        {
                            DispatchQueue.main.async {
                                 self.chuckTextView.text = value
                            }
                        
                        }
                    }
                }catch{
                        print(error)
                }
        }
        }.resume()
        
        
    }
    
    @IBAction func pastebinButton(_ sender: Any) {
        let params = "api_dev_key=391be4fd2cac31c2114eb8f467d21cc7&api_option=paste&api_paste_code=\(pastebinTextField.text ?? "no text added")"
        guard let url = URL(string: "https://pastebin.com/api/api_post.php") else{
            fatalError("error in url")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = params.data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let data = data{
                if let dataString = String(data: data, encoding: String.Encoding.utf8){
                    
                    DispatchQueue.main.async {
                        self.pastebinurl.isHidden = false
                        self.pastebinurl.text = dataString
                    }
                    print(dataString)
                }
            }else{
                print(error ?? "error in pasting")
            }
        }.resume()
        
    }
}

