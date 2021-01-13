//
//  MapVC.swift
//  MediaFinder
//
//  Created by Mohamed on 12/2/20.
//  Copyright © 2020 Refa3y. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol SendingDataProtocol: class {
    func sendingData(data: String)
}

class MapVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    //MARK:- Properties
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000
    var previousLocation: CLLocation?
    weak var delegate: SendingDataProtocol?
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        mapView.delegate = self
    }
    
    //MARK:- Actions
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK:- CLLocationManagerDelegate
extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

//MARK:- MKMapViewDelegate
extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let _ = error {
                return
            }
            
            guard let placemark = placemarks?.first else {
                return
            }
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            
            DispatchQueue.main.async {
                self.addressLabel.text = "\(streetNumber) \(streetName)"
            }
            self.delegate?.sendingData(data: "\(streetNumber) \(streetName)")
        }
    }
}

//MARK:- Private Method
extension MapVC {
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            showAlert(message: "Turn ON Location Service")
        }
    }
    
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTackingUserLocation()
        case .denied:

            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:

            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    private func startTackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    private func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}

