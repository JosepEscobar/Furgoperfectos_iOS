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
    var imageURL: URL
    
    
    init(name: String?, description: String, imageURL: URL) {
        self.name = name ?? "No name"
        self.descriptionItem = description
        self.imageURL = imageURL
    }
}

class ListViewModel: ObservableObject {
    let didChange = PassthroughSubject<ListViewModel, Never>()
    var repository: FurgoperfectosRepository?
    let defaultImg = "https://www.google.com/url?sa=i&url=https%3A%2F%2Fthenounproject.com%2Fterm%2Fno-image%2F340719%2F&psig=AOvVaw2oryJuvN5BcJ71abF_2Ha-&ust=1595787343322000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCLCntaCB6eoCFQAAAAAdAAAAABAE"
    
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
    #warning("TODO: @josepescobar, 25/07/2020, Remove force unwap on URL")
    func provideFurgoperfectos(_ furgoperfectosArray: [FurgoperfectoModel]) {
        arrayFurgoperfectos = furgoperfectosArray.map {
            FurgoperfectoViewModel(name: $0.nombre,
                                   description: "",
                                   imageURL: URL(string: $0.imagen ?? defaultImg) ?? URL(string: defaultImg)!)
        }
    }
    
    func onError(_ error: Error) {
    }
}
