//
//  MapRepository.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 04/03/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import UIKit
import warqLog

class FurgoperfectosRepository: NSObject {
    
    static let shared: FurgoperfectosRepository = FurgoperfectosRepository()
    var arrayFurgoperfectos: [FurgoperfectoModel] = []
    
    // Fetch Data from source
    ///
    /// - Parameters:
    ///   - succeed: func - call function upon succeed
    ///   - networkFail: func - call function upon netwrok fail
    ///   - serverFail: func - call function upon server fail
    ///   - businessFail: func - call function upon business fail
    func fetchData(success succeed : @escaping (() -> Void),
                          networkFailure networkFail : @escaping ((NSError) -> Void),
                          serverFailure serverFail : @escaping ((NSError) -> Void),
                          businessFailure businessFail : @escaping ((NSError) -> Void),
                          emptyList empty: @escaping((NSError) -> Void)) {
        
        guard arrayFurgoperfectos.isEmpty else {
            WarqLog.debug("Data already loaded, loding from cache")
            succeed()
            return
        }
        
        guard let url = URL(string: apiGetEverithingLight) else {
            succeed()
            return
        }
        
        let task = URLSession.shared.furgoperfectosResponseTask(with: url) { furgoperfectosResponse, response, error in
            if let furgoperfectosResponse = furgoperfectosResponse {


                self.arrayFurgoperfectos = furgoperfectosResponse
                DispatchQueue.main.async {
                    WarqLog.debug("Data loaded from server")
                    succeed()
                }
                
            }
        }
        task.resume()
    }

}
