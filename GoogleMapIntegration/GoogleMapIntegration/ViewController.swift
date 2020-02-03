//
//  ViewController.swift
//  GoogleMapIntegration
//
//  Created by RamKumar on 31/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    
    @IBOutlet weak var Map_View: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Map_View.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: 13.067439, longitude: 80.237617, zoom: 15.0)
        Map_View.camera = camera
        show_marker(position: Map_View.camera.target)
    }
    var marker = GMSMarker()
    func show_marker(position : CLLocationCoordinate2D){
        marker.isDraggable = true
        marker.position = position
        marker.title = "chennai"
        marker.snippet = "capital of tamilnadu"
        marker.map = Map_View
        
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
        title.text = "Title dfgdfgdfg adfgdfgdf rgdsg"
        title.numberOfLines = 0
        view.addSubview(title)
        return view
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("begin dragging")
    }
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("dragging")
    }
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("end dragging")
    }
}

