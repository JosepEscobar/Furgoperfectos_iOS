//
//  Furgoperfecto.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 20/03/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import MapKit

final class FurgoperfectoAnnotation: NSObject, Decodable, MKAnnotation {

    enum FurgoperfectoType: Int, Decodable {
        case furgoperfectoDefault
//        case bicycle
//        case tricycle
    }

    var type: FurgoperfectoType = .furgoperfectoDefault

    private var latitude: CLLocationDegrees = 0
    private var longitude: CLLocationDegrees = 0
    public var title: String?
    public var id: Int?
    public var furgoperfecto: FurgoperfectoDataModel?

    // This property must be key-value observable, which the `@objc dynamic` attributes provide.
    @objc dynamic var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        set {
            // For most uses, `coordinate` can be a standard property declaration without the customized getter and setter shown here.
            // The custom getter and setter are needed in this case because of how it loads data from the `Decodable` protocol.
            latitude = newValue.latitude
            longitude = newValue.longitude
        }
    }

}
