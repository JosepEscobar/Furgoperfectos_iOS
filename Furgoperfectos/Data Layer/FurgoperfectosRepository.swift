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
    func provideFurgoperfectos(_ furgoperfectosArray: [FurgoperfectoModel])
    func onError(_ error: Error)
}

final class FurgoperfectosRepository {
    #warning("TODO: @josepescobar, 25/07/2020, Remove shared instance and arrayFurgoperfectos and do it a permanent percistance")
    static let shared: FurgoperfectosRepository = FurgoperfectosRepository()
    var arrayFurgoperfectos: [FurgoperfectoModel] = []
    weak var delegate: FurgoperfectosRepositoring?

    init(delegate: FurgoperfectosRepositoring? = nil) {
        self.delegate = delegate
    }

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
    
    func fetchData() {
        guard let url = URL(string: apiGetEverithingLight) else {
            delegate?.onError(GlobalError.castingError)
            return
        }

        let task = URLSession.shared.furgoperfectosResponseTask(with: url) { [weak self] furgoperfectosResponse, response, error in
            if let furgoperfectosResponse = furgoperfectosResponse {
                self?.arrayFurgoperfectos = furgoperfectosResponse
                DispatchQueue.main.async {
                    WarqLog.debug("Data loaded from server")
                    self?.delegate?.provideFurgoperfectos(furgoperfectosResponse)
                }
            }
        }
        task.resume()
    }

}
