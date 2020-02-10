//
//  MapViewModel.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 04/03/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import UIKit
import MapKit

class MapViewModel: NSObject {

    private var annotationsArray: [FurgoperfectoAnnotation] = []

    var numberOfFurgoperfectos: Int {
        return FurgoperfectosRepository.shared.arrayFurgoperfectos.count
    }

    var annotations: [FurgoperfectoAnnotation] {
        return annotationsArray
    }

    // Fetch Data from source
    ///
    /// - Parameters:
    ///   - succeed: func - call function upon succeed
    ///   - networkFail: func - call function upon netwrok fail
    ///   - serverFail: func - call function upon server fail
    ///   - businessFail: func - call function upon business fail
    public func fetchData(success succeed : @escaping (() -> Void),
                          networkFailure networkFail : @escaping ((NSError) -> Void),
                          serverFailure serverFail : @escaping ((NSError) -> Void),
                          businessFailure businessFail : @escaping ((NSError) -> Void),
                          emptyList empty: @escaping((NSError) -> Void)) {

        FurgoperfectosRepository.shared.fetchData(success: {
            self.gatherDataFromCoordiantes()
            self.annotationsBuilder()
            succeed()
        }, networkFailure: { (error) in
            // do something
        }, serverFailure: { (error) in
            // do something
        }, businessFailure: { (error) in
            // do something
        }) { (error) in
            // do something
        }

    }

    private func annotationsBuilder() {
        for furgoperfecto in FurgoperfectosRepository.shared.arrayFurgoperfectos {
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
        for furgoperfecto in FurgoperfectosRepository.shared.arrayFurgoperfectos {
            furgoperfecto.getDataFromCoordinates()
        }
    }

}
