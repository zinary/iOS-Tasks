//
//  ViewController.swift
//  MapWithSearch
//
//  Created by RamKumar on 06/02/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class ViewController: UIViewController {
  
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()

    var resultView: UITextView?
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self

        searchController?.searchBar.sizeToFit()
        definesPresentationContext = true

    }
     let marker = GMSMarker()
    
    func createmarker(coord : CLLocationCoordinate2D){
        marker.position = coord
        marker.isDraggable = true
//        marker.icon = UIImage(named: "card4")
//        marker.icon?.preferredPresentationSizeForItemProvider = 10
        marker.appearAnimation = GMSMarkerAnimation.pop
        marker.map = mapView
    }
    
    @IBAction func search(_ sender: Any) {
    
    
   
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        let fields : GMSPlaceField = GMSPlaceField(rawValue: GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.coordinate.rawValue))!.rawValue | UInt(GMSPlaceField.placeID.rawValue))!
        autoCompleteController.placeFields = fields
        
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        autoCompleteController.autocompleteFilter = filter
        present(autoCompleteController,animated: true,completion: nil)
    }
    

}

extension ViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard status == .authorizedWhenInUse else {return}
        
        locationManager.startUpdatingLocation()
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     print("updated location")
        guard let location = locations.first else{
            print("location error ")
            return
        }
        print("location is \(location) ")

        mapView.camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15.0)
        mapView.animate(to: mapView.camera)
        locationManager.stopUpdatingLocation()
    }
}

extension ViewController : GMSAutocompleteViewControllerDelegate{
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(String(describing: place.name))")
        print("Place ID: \(String(describing: place.placeID))")
        print(place.coordinate)
        marker.map = nil
      
        mapView.camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 200.0)
        mapView.animate(to: mapView.camera)
          createmarker(coord: place.coordinate)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("error \(error.localizedDescription)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

    
}


extension ViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
}
