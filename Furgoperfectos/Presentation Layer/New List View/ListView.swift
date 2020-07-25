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
                Text(itemViewModel.name)
                Text(itemViewModel.image)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: ListViewModel())
    }
}
