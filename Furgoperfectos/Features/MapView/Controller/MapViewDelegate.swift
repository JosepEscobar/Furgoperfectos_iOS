//
//  File.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 03/11/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import Foundation
import MapKit
import Kingfisher
import warqLog

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? FurgoperfectoAnnotation else { return nil }
        
        switch annotation.type {
        case .furgoperfectoDefault:
            return FurgoperfectoAnnotationView(annotation: annotation, reuseIdentifier: FurgoperfectoAnnotationView.ReuseID)
            //        case .bicycle:
            //            return BicycleAnnotationView(annotation: annotation, reuseIdentifier: BicycleAnnotationView.ReuseID)
            //        case .tricycle:
            //            return TricycleAnnotationView(annotation: annotation, reuseIdentifier: TricycleAnnotationView.ReuseID)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        centerMap(coordinate: view.annotation?.coordinate, automaticZoom: false, isInitCenter: false)
        
        guard let annotation = view.annotation as? FurgoperfectoAnnotation else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            view.detailCalloutAccessoryView = self.getCalloutAccessoryView(annotation: annotation)
        })
        
        
    }
    
    func getCalloutAccessoryView(annotation: FurgoperfectoAnnotation) -> FurgoperfectoMapAccessoryView? {
        let bundle = Bundle.main
        if let nibView = bundle.loadNibNamed("FurgoperfectoMapAccessoryView",
                                             owner: self,
                                             options: nil)?.first as? FurgoperfectoMapAccessoryView {
            
            let url = URL(string: annotation.furgoperfecto!.imagen ?? "")
            let processor = DownsamplingImageProcessor(size: nibView.imageView.bounds.size)
            
            nibView.imageView.kf.indicatorType = .activity
            nibView.imageView.kf.setImage(
                with: url,
                placeholder: nil,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage,
                    .diskCacheExpiration(StorageExpiration.days(365))
            ]){ result in
                switch result {
                case .success(let value):
                    WarqLog.debug("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    WarqLog.error("Job failed: \(error.localizedDescription)")
                }
            }
            
            nibView.translatesAutoresizingMaskIntoConstraints = false
            return nibView
        }
        return nil
    }
    
    //Zoom to user location
    func centerMapToUser(){
        if let userLocation = locationManager.location?.coordinate {
            centerMap(coordinate: userLocation, automaticZoom: true, isInitCenter: true)
        }
    }
    
    func centerMap(coordinate: CLLocationCoordinate2D?, automaticZoom: Bool, isInitCenter: Bool) {
        if let userLocation = coordinate {
            var coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            
            if !automaticZoom {
                coordinateSpan = mapView.region.span
            }
            
            if isInitCenter {
                let viewRegion = MKCoordinateRegion(center: userLocation, span: coordinateSpan)
                mapView.setRegion(viewRegion, animated: true)
            } else {
                var userLocationModified = userLocation
                userLocationModified.latitude = userLocation.latitude - self.mapView.region.span.latitudeDelta * -0.20
                
                let viewRegion = MKCoordinateRegion(center: userLocationModified, span: coordinateSpan)
                mapView.setRegion(viewRegion, animated: true)
            }
        }
    }
}
