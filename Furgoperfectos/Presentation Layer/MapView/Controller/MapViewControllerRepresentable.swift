//
//  MapViewControllerRepresentable.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 10/02/2020.
//  Copyright © 2020 Josep Escobar. All rights reserved.
//
import SwiftUI

extension MapViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = MapViewController
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<MapViewController>) -> MapViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: String(describing: MapViewController.self)) as MapViewController
    }

    public func updateUIViewController(_ uiViewController: MapViewController, context: UIViewControllerRepresentableContext<MapViewController>) {
        
    }
}
