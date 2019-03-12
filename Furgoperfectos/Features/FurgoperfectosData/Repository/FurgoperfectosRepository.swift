//
//  MapRepository.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 04/03/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import UIKit
import Alamofire

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
            succeed()
            return
        }
        
        Alamofire.request(apiGetEverithingLight).responseData { response in

            if let _ = response.result.value {
                
                let decoder = JSONDecoder()
                let furgoperfectosResult: Result<[FurgoperfectoModel]> = decoder.decodeResponse(from: response)
                
                if furgoperfectosResult.isSuccess {
                    self.arrayFurgoperfectos = furgoperfectosResult.value ?? []
                    succeed()
                }
            }
        }
        

        
    }

}
