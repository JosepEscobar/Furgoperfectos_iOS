//
//  MainView.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 10/02/2020.
//  Copyright © 2020 Josep Escobar. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            MapViewController()
                .tabItem {
                    Image(systemName: "map")
                    Text("Mapa")
                }

            FurgoperfectosListView(viewModel: ListViewModel())
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Lista")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
