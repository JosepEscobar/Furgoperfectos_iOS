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
    
    var numberOfFurgoperfectos: Int {
        return FurgoperfectosRepository.shared.arrayFurgoperfectos.count
    }
    
    var annotations: [FurgoperfectoAnnotation] {
        var annotations: [FurgoperfectoAnnotation] = []
        
        for furgoperfecto in FurgoperfectosRepository.shared.arrayFurgoperfectos {
            let annotation: FurgoperfectoAnnotation = FurgoperfectoAnnotation()
            if let latitude = CLLocationDegrees(exactly: Double(furgoperfecto.lng!) ?? 0.0), let longitude = CLLocationDegrees(exactly: Double(furgoperfecto.lat!) ?? 0.0) {
                annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                annotation.title = furgoperfecto.nombre
                annotation.furgoperfecto = furgoperfecto
                
                if let id = furgoperfecto.id {
                    annotation.id = Int(id)
                }
                
                annotations.append(annotation)
            }
        }
        return annotations
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
            
//            for fp in FurgoperfectosRepository.shared.arrayFurgoperfectos {
//                print(fp.nombre)
//            }
            
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

}
