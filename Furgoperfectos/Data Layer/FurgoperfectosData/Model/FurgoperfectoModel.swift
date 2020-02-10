//
//  MapModel.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 04/03/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import UIKit
import CoreLocation

class FurgoperfectoModel: Codable {

    let id, icono, nombre, lat: String?
    let lng, html, htmlp: String?
    let link: String?
    let imagen: String?
    let autor, ancho, alto, destomtom: String?
    let idMember: String?
    let topicID, body: String?

    var generatedCountry: String?
    var generatedCity: String?
    var generatedAddress: String?

    enum CodingKeys: String, CodingKey {
        case id, icono, nombre, lat, lng, html, htmlp, link, imagen, autor, ancho, alto, destomtom
        case idMember = "id_member"
        case topicID = "topic_id"
        case body
    }

    func getDataFromCoordinates() {
        guard let lat = lat,
            let lng = lng,
            let latitude = Double(lng),
            let longitude = Double(lat) else {
            return
        }

        // Add below code to get address for touch coordinates.
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: {
                placemarks, error -> Void in

                if let error = error {
                    print(error)
                }

                // Place details
                guard let placeMark = placemarks?.first else { return }

                // Street address
                if let street = placeMark.thoroughfare {
                    self.generatedAddress = street
                }
                // City
                if let city = placeMark.subAdministrativeArea {
                    self.generatedCity = city
                }
                // Country
                if let country = placeMark.country {
                    self.generatedCountry = country
                }
        })
    }
}
