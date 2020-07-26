//
//  FurgoperfectoViewModel.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 26/07/2020.
//  Copyright © 2020 Josep Escobar. All rights reserved.
//

import Foundation

final class FurgoperfectoViewModel: Identifiable {
    let id: String
    var name: String
    var descriptionItem: String
    var distance: String
    var imageURL: URL
    
    init(id: String, name: String?, description: String, distance: String, imageURL: URL) {
        self.id = id
        self.name = name ?? "No name"
        self.descriptionItem = description
        self.distance = distance
        self.imageURL = imageURL
    }
}
