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

class ListViewModel: ObservableObject {
    let didChange = PassthroughSubject<ListViewModel, Never>()
    var repository: FurgoperfectosRepository?
    
    var arrayFurgoperfectos: [FurgoperfectoViewModel] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        self.repository = FurgoperfectosRepository(delegate: self)
        self.repository?.fetchData()
    }
}

extension ListViewModel: FurgoperfectosRepositoring {
    func provideFurgoperfectos(_ furgoperfectosArray: [FurgoperfectoModel]) {
        arrayFurgoperfectos = furgoperfectosArray.map {
            FurgoperfectoViewModel(name: $0.nombre,
                                   description: "",
                                   image: $0.imagen ?? "")
        }
    }
    
    func onError(_ error: Error) {
    }
}
