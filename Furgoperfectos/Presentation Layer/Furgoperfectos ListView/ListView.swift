//
//  ListView.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 10/02/2020.
//  Copyright © 2020 Josep Escobar. All rights reserved.
//

import SwiftUI

struct ListView: View {
    
    @State var viewModel: ListViewModel
    
    var body: some View {
        List(viewModel.arrayFurgoperfectos) { itemViewModel in
            VStack {
                HStack {
                    AsyncImage(
                        url: itemViewModel.imageURL,
                        placeholder: Text("Cargando...")
                        ).aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 100)
                    Text(itemViewModel.name)
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: ListViewModel())
    }
}
