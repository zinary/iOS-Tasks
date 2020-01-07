//
//  WeatherAPIService.swift
//  UrlSession
//
//  Created by Janakiraman Kanagaraj on 07/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import Foundation

class WeatherAPIService{
    
    func executeWebRequest(urlToExecute:URL , completionHandler : @escaping ([String:Any]?, _: Error?) -> Void ){
        let sharedSession = URLSession.shared
        let webRequest = URLRequest(url: urlToExecute)
        let dataTask = sharedSession.dataTask(with: webRequest) { (webData, urlResponse, apiError) in
            guard let unwrappedData = webData else {
                completionHandler(nil,apiError)
                return
            }
            
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [String:Any]
                
                completionHandler(jsonResponse,nil)
                
            }catch{
                print(error.localizedDescription)
                completionHandler(nil,error)
            }
            
            
            
        }
        dataTask.resume()
        
        
    }
}
