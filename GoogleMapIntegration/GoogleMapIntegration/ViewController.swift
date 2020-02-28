//
//  ViewController.swift
//  GoogleMapIntegration
//
//  Created by RamKumar on 31/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class ViewController: UIViewController {

    @IBOutlet weak var addressDetails: UITextView!
  
    @IBOutlet weak var likelyTableview: UITableView!
    
    @IBOutlet weak var Map_View: GMSMapView!
    let locationManager = CLLocationManager()
    var circle = GMSCircle()
  
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    
    // The currently selected place.
    var selectedPlace: GMSPlace?
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        circle.map = nil
        Map_View.delegate = self
        likelyTableview.delegate = self
        likelyTableview.dataSource = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        Map_View.isMyLocationEnabled = true
         Map_View.settings.myLocationButton = true
        locationManager.startUpdatingLocation()
        show_marker(position: Map_View.camera.target)
        
    }
    
    @IBAction func searchButton(_ sender: Any) {
           likelyTableview.reloadData()
        func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
            print("my location dot tapped")
            likelyTableview.reloadData()
            let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 15.0)
            Map_View.animate(to: camera)
        }
        
    }
    //marker
    var marker = GMSMarker()	
    func show_marker(position : CLLocationCoordinate2D){
        marker.isDraggable = true
        marker.icon = UIImage(named: "pin")
        marker.layer.opacity = 10
        marker.position = position
        marker.title = "chennai"
        marker.snippet = "capital of tamilnadu"
        marker.map = Map_View
        draw_circle()
    }
}

extension ViewController : GMSMapViewDelegate{
   
    
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("clicked on marker")
    }
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
        print("long press on marker")
    }
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 100))
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        let title = UILabel(frame: CGRect.init(x: 8, y: 8, width: view.frame.width - 50 , height: 50))
        title.text = "\(String(describing: marker.position.latitude)) , \(String(describing: marker.position.longitude))"
   
        title.adjustsFontSizeToFitWidth = true
        title.layer.opacity = 85
        title.numberOfLines = 0
        view.addSubview(title)
        return view
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("begin dragging")
        circle.map = nil
    }
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("dragging")
        
    }
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("end dragging")
        draw_circle()
        showAddress(coordinate: marker.position)
    }
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
       
        return true
    }
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        marker.position = coordinate
        print(coordinate)
        showAddress(coordinate: coordinate)
        circle.map = nil
        draw_circle()
    }
    
    func showAddress(coordinate : CLLocationCoordinate2D){
        addressDetails.text = "latitude \(coordinate.latitude) , longitude \(coordinate.longitude)"
    }
    
    
    
    func draw_circle(){
        if circle.map == nil {
        let circlePosition = marker.position
        circle = GMSCircle(position: circlePosition, radius: 200)
        circle.strokeColor = .yellow
        circle.strokeWidth = 5
        circle.map = Map_View
        }
        else{
            circle.map = nil
        }
    }
}

extension ViewController : CLLocationManagerDelegate{

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        guard status == .authorizedWhenInUse else {return}
             locationManager.startUpdatingLocation()
          Map_View.isMyLocationEnabled = true
        Map_View.settings.myLocationButton = true
        Map_View.settings.compassButton = true
      
    
  
        
    }


    
        func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        print("my location dot tapped")
    
         let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 15.0)
        Map_View.animate(to: camera)
            listLikelyPlaces()
           
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else{
            print("location error ")
            return
        }
        print("location is \(location) ")
      
            Map_View.camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15.0)
            Map_View.animate(to: Map_View.camera)
            locationManager.stopUpdatingLocation()
//        let bt =  didTapMyLocationButton(for: Map_View)
      listLikelyPlaces()
    }
    
    
  
    func listLikelyPlaces() {
        // Clean up from previous sessions.
        likelyPlaces.removeAll()
        let place = GMSPlacesClient()
        place.currentPlace(callback: { (placeLikelihoods, error) -> Void in
            if let error = error {
                // TODO: Handle the error.
                print("Current Place error: \(error.localizedDescription)")
                return
            }
            
            // Get likely places and add to the list.
            if let likelihoodList = placeLikelihoods {
                for likelihood in likelihoodList.likelihoods {
                    let place = likelihood.place
                       print("\(likelihood.place)")
                    self.likelyPlaces.append(place)
                    print("\(self.likelyPlaces)")
                    self.addressDetails.text = "\(self.likelyPlaces)"
//                    self.show_marker(position: (self.likelyPlaces.first?.coordinate)!)
                }
            }
        })
    }
    func searchPlaces(){
        
    
   likelyTableview.reloadData()
        
        
    }
}


extension ViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return likelyPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = likelyTableview.dequeueReusableCell(withIdentifier: "cellReuse", for: indexPath)
        cell.textLabel?.text = likelyPlaces[indexPath.row].name!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locationCoordinates = likelyPlaces[indexPath.row].coordinate
        marker.position = locationCoordinates
        
        circle.map = nil
        draw_circle()
        Map_View.camera = GMSCameraPosition.camera(withLatitude: locationCoordinates.latitude, longitude: locationCoordinates.longitude, zoom: 15.0)
        Map_View.animate(toZoom: 20.0)
        Map_View.animate(to: Map_View.camera)
    }
}
