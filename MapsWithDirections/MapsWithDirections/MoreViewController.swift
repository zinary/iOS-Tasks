//
//  MoreViewController.swift
//  MapsWithDirections
//
//  Created by RamKumar on 20/02/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
protocol SendData {
    func sendZone(newZone : CLLocationCoordinate2D, mode : Bool)
}

class MoreViewController: UIViewController {
    var delegate : SendData?
    @IBOutlet weak var zoneTF: UITextField!
 
    @IBOutlet weak var mode: UISwitch!
    var zoneMode : Bool?
    var zone : ( CLLocationCoordinate2D , String )?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  

 
    
    @IBAction func zoneAdd(_ sender: Any) {
        
        let autocompleateVC = GMSAutocompleteViewController()
        autocompleateVC.delegate = self
        
        let fields : GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.coordinate.rawValue))!
        autocompleateVC.placeFields = fields
        
        
        present(autocompleateVC,animated: true,completion: nil)
    }
    @IBAction func addZoneBtn(_ sender: Any) {
        print(zone as Any)
        zoneMode = mode.isOn
        if self.delegate != nil && zoneTF.text != nil {
            let newZone = zone?.0
            delegate?.sendZone(newZone: newZone!,mode: zoneMode!)
            dismiss(animated: true, completion: nil)
//            if let navController = self.navigationController {
//                navController.popViewController(animated: true)
//            }
        }
        
      
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destVC = segue.destination as! ViewController
//        destVC.zone = self.zone?.0
//
//    }

}


extension MoreViewController : GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        zoneTF.text = place.name
        zone = (place.coordinate,place.name!)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        NSLog("%s", error.localizedDescription)
        dismiss(animated: true, completion: nil)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
           dismiss(animated: true, completion: nil)
    }
    
    
}

