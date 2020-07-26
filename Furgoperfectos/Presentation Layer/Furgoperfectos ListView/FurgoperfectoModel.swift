//
//  FurgoperfectoModel.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 26/07/2020.
//  Copyright © 2020 Josep Escobar. All rights reserved.
//

import CoreLocation

final class FurgoperfectoModel  {
    let id: String
    let icon: String?
    let name: String?
    let html: String?
    let htmlp: String?
    let coordinates: Place
    let link: String?
    let imagen: String?
    let autor: String?
    let ancho: String?
    let alto: String?
    let destomtom: String?
    let idMember: String?
    let topicID: String?
    let body: String?
    
    init?(dataModel: FurgoperfectoDataModel) {
        // the coordinates come inverted from backend
        guard let latitude = dataModel.lng,
            let longitude = dataModel.lat,
            let id = dataModel.id else { return nil }
        let place = Place(latitude: CLLocationDegrees(Double(latitude) ?? 0),
                          longitude: CLLocationDegrees(Double(longitude) ?? 0))
        self.id = id
        self.icon = dataModel.icono
        self.name = dataModel.nombre
        self.html = dataModel.html
        self.htmlp = dataModel.htmlp
        self.coordinates = place
        self.link = dataModel.link
        self.imagen = dataModel.imagen
        self.autor = dataModel.autor
        self.ancho = dataModel.ancho
        self.alto = dataModel.alto
        self.destomtom = dataModel.destomtom
        self.idMember = dataModel.idMember
        self.topicID = dataModel.topicID
        self.body = dataModel.body
    }

//    var generatedCountry: String?
//    var generatedCity: String?
//    var generatedAddress: String?

//    func getDataFromCoordinates() {
//        guard let lat = lat,
//            let lng = lng,
//            let latitude = Double(lng),
//            let longitude = Double(lat) else {
//            return
//        }
//
//        // Add below code to get address for touch coordinates.
//        let geoCoder = CLGeocoder()
//        let location = CLLocation(latitude: latitude, longitude: longitude)
//        geoCoder.reverseGeocodeLocation(location, completionHandler: {
//                placemarks, error -> Void in
//
//                if let error = error {
//                    print(error)
//                }
//
//                // Place details
//                guard let placeMark = placemarks?.first else { return }
//
//                // Street address
//                if let street = placeMark.thoroughfare {
//                    self.generatedAddress = street
//                }
//                // City
//                if let city = placeMark.subAdministrativeArea {
//                    self.generatedCity = city
//                }
//                // Country
//                if let country = placeMark.country {
//                    self.generatedCountry = country
//                }
//        })
//    }
}
