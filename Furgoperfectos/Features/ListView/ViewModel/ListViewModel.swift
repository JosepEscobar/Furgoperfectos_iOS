//
//  ListViewModel.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 12/03/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import UIKit

class ListViewModel: NSObject {
    
    var numberOfFurgoperfectos: Int {
        return FurgoperfectosRepository.shared.arrayFurgoperfectos.count
    }
    
    func getName(index: Int) -> String {
        return FurgoperfectosRepository.shared.arrayFurgoperfectos[index].nombre ?? ""
    }
    
    func getDescription(index: Int) -> String {
        return FurgoperfectosRepository.shared.arrayFurgoperfectos[index].html ?? ""
    }
    
    func getImage(index: Int) -> String {
        return FurgoperfectosRepository.shared.arrayFurgoperfectos[index].imagen ?? ""
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
