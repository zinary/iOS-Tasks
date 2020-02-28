//
//  ViewController.swift
//  MapsWithDirections
//
//  Created by RamKumar on 10/02/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import Alamofire
import SwiftyJSON

class ViewController: UIViewController , SendData{
    func sendZone(newZone: CLLocationCoordinate2D , mode : Bool) {
        zone = newZone
        self.mode = mode
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMore"{
            let secondVC: MoreViewController = segue.destination as! MoreViewController
            secondVC.delegate = self
        }
    }
   
    
    enum Location {
        case sourceLocation
        case destinationLocation
        case waypoint
    }
    

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var startLocationTF: UITextField!
    @IBOutlet weak var endLocationTF: UITextField!
    @IBOutlet weak var waypointButton: UIButton!
    @IBOutlet weak var waypointTF: UITextField!
    
    let locationManager = CLLocationManager()
    var selectedLocation = Location.sourceLocation
    var searchLocation : ( CLLocationCoordinate2D , String )?
    var startLocation : ( CLLocationCoordinate2D , String )?
    var endLocation : ( CLLocationCoordinate2D , String )?
    var waypointLocation : ( CLLocationCoordinate2D , String )?
    var waypointEnabled : Bool = false
     var zonepath = GMSMutablePath()
     var zone : CLLocationCoordinate2D?
    var mode : Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
//        mapView.mapType = .hybrid
        waypointTF.layer.isHidden = true
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        mapView.camera = GMSCameraPosition.init(latitude: 11.1271, longitude:78.6569, zoom: 5.0)
       
      
//        let circleCenter = CLLocationCoordinate2D(latitude: 11.059821, longitude: 78.387451)
//        let circ = GMSCircle(position: circleCenter, radius: 100000)
//        circ.strokeWidth = 5
//        circ.map = mapView
       
    }
    var marker1 = GMSMarker()
    var marker2 = GMSMarker()
    var marker3 = GMSMarker()
//     create marker
    func createMarker(coordinate : CLLocationCoordinate2D , title : String , map : GMSMapView , selectedLocation : Location){
       
        if selectedLocation == .sourceLocation{
            marker1.icon = GMSMarker.markerImage(with: .green)
            marker1.title = "Source : " + title
            marker1.tracksViewChanges = true
            marker1.position = coordinate
            marker1.map = map
        }
        else if selectedLocation == .destinationLocation {
            marker2.icon = GMSMarker.markerImage(with: .red)
            marker2.title = "Destination : " + title
            marker2.tracksViewChanges = true
            marker2.position = coordinate
            marker2.map = map
        }
        else {
            marker3.icon = GMSMarker.markerImage(with: .blue)
            marker3.title = "Waypoint : " + title
            marker3.tracksViewChanges = true
            marker3.position = coordinate
            marker3.map = map
        }
        
       
    }
    var polyline = GMSPolyline()
    
    func drawPath(sourcelocation : CLLocationCoordinate2D , destinationLocation : CLLocationCoordinate2D , waypointLocation : CLLocationCoordinate2D? ,wayPointEnabled : Bool ) {
        let origin = "\(sourcelocation.latitude),\(sourcelocation.longitude)"
        let destination = "\(destinationLocation.latitude),\(destinationLocation.longitude)"
    
        var waypoint : String?
        var waypointLat : CLLocationDegrees
        var waypointLon : CLLocationDegrees
        
        if waypointLocation != nil {
            waypointLon = (waypointLocation?.longitude)!
            waypointLat =  (waypointLocation?.latitude)!
             waypoint  = "\(waypointLat),\(waypointLon)"
        }
        
        var url = ""
        
        if wayPointEnabled == true {
            url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&waypoints=\(waypoint!)&key=AIzaSyBDbg1dErzVZa6ZBf8kY-WzQE9mx9xlUis"
        }
        else {
             url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&key=AIzaSyBDbg1dErzVZa6ZBf8kY-WzQE9mx9xlUis"
        }
        
        
        Alamofire.request(url).responseJSON { (response) in
//            print(response.data as Any)
            print(response.response as Any)
//            print(response.result)
            print(response.request as Any)
           
            do {
                let json = try JSON(data: response.data!)
                print(json)
                
                let routes = json["routes"].arrayValue

                for route in routes{
                  
                    let routeOverviewPolyline = route["overview_polyline"].dictionary
                    let points = routeOverviewPolyline?["points"]?.stringValue
                    let path = GMSPath.init(fromEncodedPath: points!)
                    let distance = GMSGeometryLength(path!)
                    print(distance/1000)
                    self.polyline = GMSPolyline.init(path: path)
                    self.polyline.strokeWidth = 5
                    self.polyline.strokeColor = .red
                    self.polyline.map = self.mapView
                }
            }
            catch{
                print("error json")
            }
        }
    }
    @IBAction func AddWaypoint(_ sender: Any) {
        
       
        waypointTF.layer.isHidden = waypointTF.layer.isHidden ? false : true
        waypointEnabled = waypointTF.layer.isHidden ? false : true
        marker3.map = nil
        polyline.map = nil
        waypointLocation = nil
        waypointTF.text = "" 
        if waypointTF.layer.isHidden {
            waypointButton.setTitle("Add waypoint", for: .normal)
        }  else{
            waypointButton.setTitle("Remove", for: .normal)
    }
    }
    @IBAction func startlocation(_ sender: Any) {
         selectedLocation = .sourceLocation
         marker1.map = nil
         startLocationTF.text = ""
         polyline.map = nil
        
        let autocompleateVC = GMSAutocompleteViewController()
        autocompleateVC.delegate = self
        
        let fields : GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.coordinate.rawValue))!
        autocompleateVC.placeFields = fields
        

        
        present(autocompleateVC,animated: true,completion: nil)

    }
// for adding waypoint text field
    
    @IBAction func waypointAdd(_ sender: Any) {
        selectedLocation = .waypoint
        marker3.map = nil
        polyline.map = nil
        waypointTF.text = ""
        
        createZone()
        
        let autocompleateVC = GMSAutocompleteViewController()
        autocompleateVC.delegate = self
        
        let fields : GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.coordinate.rawValue))!
        autocompleateVC.placeFields = fields
      
        
        present(autocompleateVC,animated: true,completion: nil)
        
    }
    
    @IBAction func endlocation(_ sender: Any) {
        selectedLocation = .destinationLocation
         marker2.map = nil
         polyline.map = nil
        endLocationTF.text = ""

        let autocompleateVC = GMSAutocompleteViewController()
        autocompleateVC.delegate = self
        
        let fields : GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.coordinate.rawValue))!
        autocompleateVC.placeFields = fields
//
//        let filter = GMSAutocompleteFilter()
//        filter.type = .noFilter
//        autocompleateVC.autocompleteFilter = filter
        
        present(autocompleateVC,animated: true,completion: nil)

        
    }
    
   
    
    @IBAction func getDirectionsBtn(_ sender: Any) {
        var msg = ""
        guard (startLocation != nil) else {return}
        guard (endLocation != nil) else {return}
        
        if waypointEnabled {
            guard (waypointLocation != nil) else {return}
        }
        
        if  mode! != true{
            //circle
        
        if let startloc = startLocation?.0 {
            let distance = GMSGeometryDistance(zone!, (startloc))
//            print("distance")
//            print("\(distance/1000)km")
            if distance <= circ.radius{
                print("YES: you are in this polygon.")
                    msg = "YES: you are in the delivery zone."
                }
            else {
                    print("You do not appear to be in the delivery zone.")
                    msg = "You do not appear to be in this  delivery zone."
                }
        }
        }

        else {
            if GMSGeometryContainsLocation((startLocation?.0)!,zonepath , true) {
                print("YES: you are in this polygon.")
                msg = "YES: you are in the delivery zone."
            } else {
                print("You do not appear to be in the delivery zone.")
                msg = "You do not appear to be in this  delivery zone."
            }

        }
        
        let alertController = UIAlertController(title: "Alert", message:
            msg , preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
        polyline.map = nil
        
        mapView.animate(to: GMSCameraPosition.init(latitude: (startLocation?.0.latitude)!, longitude: (startLocation?.0.longitude)!, zoom: 12))
        drawPath(sourcelocation: ((startLocation?.0)! ), destinationLocation: ((endLocation?.0)!), waypointLocation: waypointLocation?.0 ,wayPointEnabled: waypointEnabled)
       
    }
    var circ = GMSCircle()
    override func viewWillAppear(_ animated: Bool) {
        print(zone as Any)
        guard zone != nil else {  return }
        circ.map = nil
         createZone()
        let camera = GMSCameraPosition(latitude: (zone?.latitude)!, longitude: (zone?.longitude)!, zoom: 15)
        mapView.animate(to: camera)
    }
   
    func createZone() {

        print("zone created")
        

        if mode! {
            //polygon
            
            zonepath.add(zone!)
            print(zonepath)
            let polygon = GMSPolygon(path: zonepath)
            polygon.fillColor = UIColor(red: 0.25, green: 0, blue: 0, alpha: 0.25);
            polygon.strokeColor = .black
            polygon.strokeWidth = 2
            polygon.map = mapView
            print("zone created 2")
        }
        else{
            //circle
            let circleCenter = CLLocationCoordinate2D(latitude: (zone?.latitude)! , longitude: (zone?.longitude)!)
                    circ = GMSCircle(position: circleCenter, radius: 1000)
                    circ.strokeWidth = 5
                    circ.fillColor = UIColor(red: 0.25, green: 0, blue: 0, alpha: 0.25);
                    circ.map = mapView
        }
        
    }
   
}


extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {return}
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.settings.zoomGestures = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        locationManager.stopUpdatingLocation()
    }
    
}


extension ViewController : GMSAutocompleteViewControllerDelegate{
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
         dismiss(animated: true, completion: nil)
        
        if selectedLocation == .sourceLocation{
           
            startLocation = ( place.coordinate , place.name!)
            startLocationTF.text = startLocation?.1
            createMarker(coordinate: startLocation!.0,title: startLocation!.1 ,map: mapView,selectedLocation: selectedLocation)
        }
        else if selectedLocation == .destinationLocation{
            endLocation = ( place.coordinate , place.name!)
            endLocationTF.text = endLocation?.1
            createMarker(coordinate: endLocation!.0,title: endLocation!.1 ,map: mapView,selectedLocation: selectedLocation)
        }
        else {
            waypointLocation = ( place.coordinate , place.name!)
            waypointTF.text = waypointLocation?.1
            createMarker(coordinate: waypointLocation!.0,title: waypointLocation!.1 ,map: mapView,selectedLocation: selectedLocation)
        }

    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
        dismiss(animated: true, completion: nil)
    
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {

        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
}
