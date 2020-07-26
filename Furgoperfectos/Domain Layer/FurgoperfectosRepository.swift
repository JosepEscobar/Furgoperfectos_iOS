//
//  MapRepository.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 04/03/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import UIKit
import warqLog

protocol FurgoperfectosRepositoring: AnyObject {
    func provideFurgoperfectos(_ furgoperfectosArray: [FurgoperfectoDataModel])
    func onError(_ error: Error)
}

final class FurgoperfectosRepository {
    #warning("TODO: @josepescobar, 25/07/2020, do it a permanent percistance")
    weak var delegate: FurgoperfectosRepositoring?

    init(delegate: FurgoperfectosRepositoring? = nil) {
        self.delegate = delegate
    }

    func fetchData() {
        guard let url = URL(string: apiGetEverithingLight) else {
            delegate?.onError(GlobalError.castingError)
            return
        }

        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        config.urlCache = nil
        
        let session = URLSession.init(configuration: config)

        let task = session.furgoperfectosResponseTask(with: url) { [weak self] furgoperfectosResponse, response, error in
            if let furgoperfectosResponse = furgoperfectosResponse {
                DispatchQueue.main.async {
                    WarqLog.debug("Data loaded from server")
                    self?.delegate?.provideFurgoperfectos(furgoperfectosResponse)
                }
            }
        }
        task.resume()
    }

}
