//
//  MapViewModel.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 04/03/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import UIKit
import MapKit

protocol MapViewModelStateProtocol: AnyObject {
    func reloadData()
}

final class MapViewModel {

    private var annotationsArray: [FurgoperfectoAnnotation] = []
    var arrayFurgoperfectos: [FurgoperfectoModel] = []
    weak var delegate: MapViewModelStateProtocol?
    var repository: FurgoperfectosRepository?
    

    var numberOfFurgoperfectos: Int {
        arrayFurgoperfectos.count
    }

    var annotations: [FurgoperfectoAnnotation] {
        annotationsArray
    }
    
    init(delegate: MapViewModelStateProtocol) {
        self.delegate = delegate
        self.repository = FurgoperfectosRepository(delegate: self)
        self.repository?.fetchData()
    }

    private func annotationsBuilder() {
        for furgoperfecto in arrayFurgoperfectos {
            guard let lat = furgoperfecto.lat,
                let lng = furgoperfecto.lng,
                let latitudeVal = Double(lat),
                let longitudeVal = Double(lng) else {
                return
            }

            let annotation: FurgoperfectoAnnotation = FurgoperfectoAnnotation()
            if let latitude = CLLocationDegrees(exactly: longitudeVal),
                let longitude = CLLocationDegrees(exactly: latitudeVal) {
                annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                annotation.title = furgoperfecto.nombre
                annotation.furgoperfecto = furgoperfecto

                if let id = furgoperfecto.id {
                    annotation.id = Int(id)
                }

                annotationsArray.append(annotation)
            }
        }
    }

    private func gatherDataFromCoordiantes() {
        for furgoperfecto in arrayFurgoperfectos {
            furgoperfecto.getDataFromCoordinates()
        }
    }

}

extension MapViewModel: FurgoperfectosRepositoring {
    func provideFurgoperfectos(_ furgoperfectosArray: [FurgoperfectoModel]) {
        self.arrayFurgoperfectos = furgoperfectosArray
        self.gatherDataFromCoordiantes()
        self.annotationsBuilder()
        self.delegate?.reloadData()
    }
    
    func onError(_ error: Error) {
    }
    
    
}
