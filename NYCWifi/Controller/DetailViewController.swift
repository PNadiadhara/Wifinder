//
//  DetailViewController.swift
//  NYCWifi
//
//  Created by Pritesh Nadiadhara on 3/1/21.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    let detailView = DetailView()
    public var hotspot: Hotspot!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    private func setupMap() {
        detailView.mapKitView.delegate = self
        let regionRadius: CLLocationDistance = 650
        let initialLocation = CLLocation(latitude: Double(hotspot!.lat) ?? 0.0, longitude: Double(hotspot.long) ?? 0.0)
        let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        detailView.mapKitView.setRegion(coordinateRegion, animated: false)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: initialLocation.coordinate.latitude, longitude: initialLocation.coordinate.longitude)
        annotation.title = hotspot.locationName
        detailView.mapKitView.addAnnotation(annotation)
        
    }
    
    @objc private func showActionAlert() {
        let alert = UIAlertController(title: "Options", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Save Hotspot", style: .default, handler: { (action) in
            self.saveButtonPressed()
        }))
    }
    
    private func saveButtonPressed() {
        if let newHotspot = hotspot {
         HotspotDataManager.addHotspot(hotspot: newHotspot)
            showAlert(title: nil, message: "Hotspot Saved", actionTitle: "OK")
        }
    }
   

}


extension DetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView.markerTintColor = UIColor.init(displayP3Red: 247/255, green: 195/255, blue: 106/255, alpha: 1)
        annotationView.glyphImage =  UIImage(named: "wifi")
        return annotationView
    }
}
