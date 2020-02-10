//
//  ListViewModel.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 12/03/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import SwiftUI
import Combine

class FurgoperfectoViewModel: NSObject, Identifiable {
    
    var name: String
    var descriptionItem: String
    var image: String
    
    init(name: String?, description: String, image: String) {
        self.name = name ?? "No name"
        self.descriptionItem = description
        self.image = image
    }

}

class NewListViewModel: ObservableObject {
    let didChange = PassthroughSubject<NewListViewModel, Never>()
    
    var arrayFurgoperfectos: [FurgoperfectoViewModel] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        
        fetchData(success: {
            
        }, networkFailure: { (NSError) in
            
        }, serverFailure: { (NSError) in
            
        }, businessFailure: { (NSError) in
            
        }, emptyList: { error in
        })
    }
    
    
    public func fetchData(success succeed : @escaping (() -> Void),
                          networkFailure networkFail : @escaping ((NSError) -> Void),
                          serverFailure serverFail : @escaping ((NSError) -> Void),
                          businessFailure businessFail : @escaping ((NSError) -> Void),
                          emptyList empty: @escaping((NSError) -> Void)) {
        
        FurgoperfectosRepository.shared.fetchData(success: {
            self.arrayFurgoperfectos = FurgoperfectosRepository.shared.arrayFurgoperfectos.map { FurgoperfectoViewModel(name: $0.nombre,
                                                                                                                        description: "",
                                                                                                                        image: $0.imagen ?? ""
                ) }
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

final class ListViewModel {
    
    var numberOfFurgoperfectos: Int {
        return FurgoperfectosRepository.shared.arrayFurgoperfectos.count
    }

    func getName(index: Int) -> String {
        return FurgoperfectosRepository.shared.arrayFurgoperfectos[index].nombre ?? ""
    }

    func getDescription(index: Int) -> String {
        return "\(FurgoperfectosRepository.shared.arrayFurgoperfectos[index].generatedCountry ?? "") \(FurgoperfectosRepository.shared.arrayFurgoperfectos[index].generatedCity ?? "") \(FurgoperfectosRepository.shared.arrayFurgoperfectos[index].generatedAddress ?? "")"
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
