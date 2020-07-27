//
//  ListView.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 10/02/2020.
//  Copyright © 2020 Josep Escobar. All rights reserved.
//

import SwiftUI

struct FurgoperfectosListView: View {
    @State var viewModel: FurgoperfectoListViewModel
    
    enum Constant {
        static let title = "Furgoperfectos 🚐"
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.arrayFurgoperfectos) { itemViewModel in
                NavigationLink(destination: FurgoperfectosDetailView(state: itemViewModel)) {
                    FurgoperfectoRowView(imageURL: itemViewModel.imageURL,
                                         name: itemViewModel.name,
                                         distance: itemViewModel.distance)
                }
            }
            .navigationBarTitle(Constant.title)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        FurgoperfectosListView(viewModel: FurgoperfectoListViewModel())
    }
}
