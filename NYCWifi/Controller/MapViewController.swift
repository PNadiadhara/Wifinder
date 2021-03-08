//
//  ViewController.swift
//  NYCWifi
//
//  Created by Pritesh Nadiadhara on 2/23/21.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    let mainView = MainMapView()
    private let locationManager = CLLocationManager()
    private var searchCoordinates = CLLocationCoordinate2D(latitude: 40.7447, longitude: -73.9485)
    private var myCurrentArea = MKCoordinateRegion() {
        didSet {
            self.mainView.mapView.reloadInputViews()
        }
    }
    private var hotspots = [Hotspot]() {
        didSet {
            DispatchQueue.main.async {
                self.mainView.mainTableView.reloadData()
            }
        }
    }
    private var annotations = [MKPointAnnotation]()
    private var searchAnnotations = [MKPointAnnotation]() {
        didSet {
            DispatchQueue.main.async {
                self.mainView.mapView.reloadInputViews()
                self.mainView.mapView.addAnnotations(self.searchAnnotations)
                guard !self.searchAnnotations.isEmpty else {
                    return
                }
                let region = MKCoordinateRegion(center: self.searchAnnotations.first!.coordinate, latitudinalMeters: 2400, longitudinalMeters: 2400)
                self.mainView.mapView.setRegion(region, animated: false)
            }
        }
    }
    private var searchHotspots = [Hotspot]() {
        didSet {
            DispatchQueue.main.async {
                self.mainView.mainTableView.reloadData()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hotspots"
        self.view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        view.addSubview(mainView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "locate"), style: .plain, target: self, action: #selector(currentLocationButton))
        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
        mainView.search.delegate =  self
        mainView.mapView.delegate = self
        locationManager.delegate = self
        checkLocationServices()
        loadHotspots()
        setupKeyboardToolbar()
    }
    
    func updateResultsWithinRadiusOfCurrentLocation(myLocation : CLLocation) {
        searchHotspots.removeAll()
        for hotspot in hotspots {
            if myLocation.distance(from: CLLocation(latitude: Double(hotspot.lat) ?? 0.0, longitude: Double(hotspot.long) ?? 0.0)) < 200 {
                searchHotspots.append(hotspot)
            }
        }
    }
    
    @objc private func currentLocationButton() {
        mainView.mapView.setCenter(myCurrentArea.center, animated: true)
        let myLocation = CLLocation(latitude: myCurrentArea.center.latitude, longitude: myCurrentArea.center.longitude)
        updateResultsWithinRadiusOfCurrentLocation(myLocation: myLocation)
        
    }
    
    private func getHotspots() {
        HotspotAPIClient.searchWifiSpot { (error, hotspots, annotations) in
            if let error = error {
                print(error)
            } else if let hotspots = hotspots {
                self.hotspots = hotspots
                self.searchHotspots = hotspots
                HotspotCacheDataManager.saveToCache(hotspots: hotspots)
                DispatchQueue.main.async {
                    self.mainView.mainTableView.reloadData()
                }
                if let annotations = annotations {
                    self.annotations = annotations
                    self.searchAnnotations = annotations
                    DispatchQueue.main.async {
                        self.mainView.mapView.addAnnotations(self.searchAnnotations)
                    }
                    
                    let region = MKCoordinateRegion(center: self.searchAnnotations.first!.coordinate, latitudinalMeters: 2400, longitudinalMeters: 2400)
                    DispatchQueue.main.async {
                        self.mainView.mapView.setRegion(region, animated: false)
                    }
                }
            }
        }
    }
    
    private func loadHotspots() {
        hotspots = HotspotCacheDataManager.loadFromCache().hotspots
        annotations = HotspotCacheDataManager.loadFromCache().annotations
        searchHotspots = hotspots
        searchAnnotations = annotations
        mainView.mapView.addAnnotations(self.searchAnnotations)
        if let firstAnnotation = annotations.first {
            let region = MKCoordinateRegion(center: firstAnnotation.coordinate,
                                            latitudinalMeters: 2400,
                                            longitudinalMeters: 2400)
            self.mainView.mapView.setRegion(region, animated: false)
        }
        if hotspots.isEmpty {
            getHotspots()
        }
    }
    
    func checkLocationServices() {
        if CLAuthorizationStatus.authorizedWhenInUse == .authorizedWhenInUse {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            mainView.mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            mainView.mapView.showsUserLocation = true
        }
    }
    
    private func setupKeyboardToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done
                                                       , target: self, action: #selector(doneButtonAction))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        mainView.search.inputAccessoryView = toolbar
    }
    @objc private func doneButtonAction() {
        self.view.endEditing(true)
        self.resignFirstResponder()
    }
}

//MARK: - TableView Extention
extension MapViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchHotspots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let hotspotToSet = searchHotspots[indexPath.row]
        cell.textLabel?.text = hotspotToSet.locationName
        cell.textLabel?.textAlignment = .center
        cell.detailTextLabel?.text = hotspotToSet.ssid
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        cell.textLabel?.shadowColor = #colorLiteral(red: 0.5019607843, green: 0.9294117647, blue: 0.6, alpha: 1)
        cell.textLabel?.shadowOffset = CGSize(width: 0, height: 2)
        cell.textLabel?.textColor = .black
        cell.selectionStyle = .none
        cell.backgroundColor = #colorLiteral(red: 0.7803921569, green: 0.9764705882, blue: 0.8, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailViewController()
        detailVC.hotspot = searchHotspots[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "WiFi Hotspots"
    }
    
    
}

//MARK: - SearchBar Extention
extension MapViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        mainView.mapView.removeAnnotations(searchAnnotations)
        self.searchHotspots.removeAll()
        self.searchAnnotations.removeAll()
        
        guard let text = searchBar.text, let number = Int(text), text.count == 5 else {
            showAlert(title: nil, message: "Enter Valid Zipcode", actionTitle: "OK")
            return
        }
        
        searchHotspots = hotspots.filter{
            $0.zipcode == String(number)
        }
        searchAnnotations = searchHotspots.map {
            let annotaion = MKPointAnnotation()
            annotaion.coordinate = CLLocationCoordinate2D(latitude: Double($0.lat) ?? 0.0, longitude: Double($0.long) ?? 0.0)
            return annotaion
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchHotspots = hotspots
            searchAnnotations = annotations
        }
    }
    
}

//MARK: - MKMapview Extention
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView.markerTintColor = UIColor.init(displayP3Red: 87/255, green: 204/255, blue: 153/255, alpha: 1)
        //TODO: - add UIImage named wifi
        annotationView.glyphImage = UIImage(named: "wifi")
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let detailVC = DetailViewController()
        guard let annotation = view.annotation else {
            return
        }
        let index = hotspots.firstIndex{
            Double($0.lat) == annotation.coordinate.latitude && Double($0.long) == annotation.coordinate.longitude}
        if let selectedHotspot = index {
            let hotspot = hotspots[selectedHotspot]
            detailVC.hotspot = hotspot
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

//MARK: - LocationManager Extention
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            searchCoordinates = myCurrentArea.center
        }
        let currentArea = MKCoordinateRegion(center: searchCoordinates, latitudinalMeters: 500, longitudinalMeters: 500)
        mainView.mapView.setRegion(currentArea, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        myCurrentArea = MKCoordinateRegion()
        if let currentLocation = locations.last {
            myCurrentArea = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        } else {
            myCurrentArea = MKCoordinateRegion(center: searchCoordinates, latitudinalMeters: 500, longitudinalMeters: 500)
        }
    }
}


