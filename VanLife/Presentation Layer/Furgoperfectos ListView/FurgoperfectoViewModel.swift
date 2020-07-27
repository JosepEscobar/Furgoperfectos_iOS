//
//  FurgoperfectoViewModel.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 26/07/2020.
//  Copyright © 2020 Josep Escobar. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

final class FurgoperfectoViewModel: Identifiable {
    let id: String
    var name: String
    var descriptionItem: String
    var distance: String
    var imageURL: URL
    var forumURL: URL
    var coordinates: CLLocation
    
    init(id: String,
         name: String?,
         description: String,
         distance: String,
         imageURL: URL,
         forumURL: URL,
         coordinates: CLLocation) {
        self.id = id
        self.name = name ?? "No name"
        self.descriptionItem = description
        self.distance = distance
        self.imageURL = imageURL
        self.forumURL = forumURL
        self.coordinates = coordinates
    }
    
    func open(url: URL) {
        UIApplication.shared.open(url)
    }
    
    func openMaps(coordinates: CLLocation, title: String?) {
        let latitude = coordinates.coordinate.latitude
        let longitude = coordinates.coordinate.longitude
        let application = UIApplication.shared
        let coordinate = "\(latitude),\(longitude)"
        let encodedTitle = title?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let handlers = [
            ("Apple Maps", "http://maps.apple.com/?q=\(encodedTitle)&ll=\(coordinate)"),
            ("Google Maps", "comgooglemaps://?q=\(coordinate)"),
            ("Waze", "waze://?ll=\(coordinate)"),
            ("Citymapper", "citymapper://directions?endcoord=\(coordinate)&endname=\(encodedTitle)")
        ]
            .compactMap { (name, address) in URL(string: address).map { (name, $0) } }
            .filter { (_, url) in application.canOpenURL(url) }

        guard handlers.count > 1 else {
            if let (_, url) = handlers.first {
                application.open(url, options: [:])
            }
            return
        }
        let alert = UIAlertController(title: "Selecciona la app de navegación", message: nil, preferredStyle: .actionSheet)
        handlers.forEach { (name, url) in
            alert.addAction(UIAlertAction(title: name, style: .default) { _ in
                application.open(url, options: [:])
            })
        }
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.presentAlert()
    }
}
