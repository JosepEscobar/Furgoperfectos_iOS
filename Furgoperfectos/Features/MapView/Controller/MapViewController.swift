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

    @IBOutlet private weak var mapView: MKMapView!
    private let mapViewModel = MapViewModel()
    private let locationManager = CLLocationManager()
    private var userTrackingButton: MKUserTrackingButton!
    private var scaleView: MKScaleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        requestLocationAccess()
        setupUserTrackingButtonAndScaleView()
        registerAnnotationViewClasses()
        centerMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    private func setupUserTrackingButtonAndScaleView() {
        mapView.showsUserLocation = true
        
        userTrackingButton = MKUserTrackingButton(mapView: mapView)
        userTrackingButton.layer.backgroundColor = UIColor.translucentButtonColor!.cgColor
        userTrackingButton.layer.borderColor = UIColor.white.cgColor
        userTrackingButton.layer.borderWidth = 1
        userTrackingButton.layer.cornerRadius = 5
        userTrackingButton.isHidden = true // Unhides when location authorization is given.
        view.addSubview(userTrackingButton)
        
        // By default, `MKScaleView` uses adaptive visibility, so it only displays when zooming the map.
        // This is behavior is confirgurable with the `scaleVisibility` property.
        scaleView = MKScaleView(mapView: mapView)
        scaleView.legendAlignment = .trailing
        view.addSubview(scaleView)
        
        let stackView = UIStackView(arrangedSubviews: [scaleView, userTrackingButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                                     stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)])
    }
    
    private func registerAnnotationViewClasses() {
        mapView.register(FurgoperfectoAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(BicycleAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(TricycleAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(ClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
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
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }

}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? FurgoperfectoAnnotation else { return nil }
        
        switch annotation.type {
        case .furgoperfectoDefault:
            return FurgoperfectoAnnotationView(annotation: annotation, reuseIdentifier: FurgoperfectoAnnotationView.ReuseID)
        case .bicycle:
            return BicycleAnnotationView(annotation: annotation, reuseIdentifier: BicycleAnnotationView.ReuseID)
        case .tricycle:
            return TricycleAnnotationView(annotation: annotation, reuseIdentifier: TricycleAnnotationView.ReuseID)
        }
    }
    
    //Zoom to user location
    func centerMap() {
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapView.setRegion(viewRegion, animated: false)
        }
    }

}


extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        let locationAuthorized = status == .authorizedWhenInUse
        userTrackingButton.isHidden = !locationAuthorized
    }
}
