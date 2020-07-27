//
//  Place.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 26/07/2020.
//  Copyright © 2020 Josep Escobar. All rights reserved.
//

import CoreLocation
import Foundation

struct Place {
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees

    var location: CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }

    func distance(to location: CLLocation) -> CLLocationDistance {
        return location.distance(from: self.location)
    }
}
