//
//  FurgoperfectosDetailView.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 25/07/2020.
//  Copyright © 2020 Josep Escobar. All rights reserved.
//

import SwiftUI
import Foundation

struct FurgoperfectosDetailView : View {
    var id: String

    var body: some View {
        VStack {
            //Image(item.mainImage)
            Text(id)
        }
        .navigationBarTitle("item.name")
    }
}
