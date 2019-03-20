//
//  ViewController.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 04/03/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import PKHUD


class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let mapViewModel = MapViewModel()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        requestLocationAccess()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }

    func fetchData() {
        HUD.show(.label("Cargando Furgoperfectos..."))
        mapViewModel.fetchData(success: {
            //
            self.mapView.addAnnotations(self.mapViewModel.annotations)
            HUD.flash(.success, delay: 1.0)
            
        }, networkFailure: { (error) in
            
        }, serverFailure: { (error) in
            
        }, businessFailure: { (error) in
            
        }) { (error) in
            
        }
    }
    
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }

}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation is MKUserLocation {
//            return nil
//        }
//            
//        else {
//            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
//            //annotationView.image = UIImage(named: "place icon")
//            return annotationView
//        }
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
        }
    }

}


