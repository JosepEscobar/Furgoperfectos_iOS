//
//  FurgoperfectosDetailView.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 25/07/2020.
//  Copyright © 2020 Josep Escobar. All rights reserved.
//

import SwiftUI
import CoreLocation
import Foundation

struct FurgoperfectosDetailView : View {
    var state: FurgoperfectoViewModel

    var body: some View {
        VStack {
            AsyncImage(
                url: state.imageURL,
                placeholder: Text("Cargando...")
            )
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
            Text(state.name).padding()
            Button("Abrir post del foro", action: open(url: state.forumURL)).padding()
            Button("Abrir aplicación de navegación", action: openMap(coordinates: state.coordinates, title: state.name)).padding()
            Spacer()
        }
        .navigationBarTitle(state.name)
    }
    
    private func open(url: URL) -> () -> () {
        return {
            self.state.open(url: url)
        }
    }
    
    private func openMap(coordinates: CLLocation, title: String) -> () -> () {
        return {
            self.state.openMaps(coordinates: coordinates, title: title)
        }
    }
}

struct FurgoperfectosDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = FurgoperfectoViewModel(id: "12",
                                               name: "Mi furgoperfecto",
                                               description: "Mi fugro descripión",
                                               distance: "Muy cerca",
                                               imageURL: URL(string: "https://i.ytimg.com/vi/iXSxc6bnANk/maxresdefault.jpg")!,
                                               forumURL: URL(string: "https://i.ytimg.com/vi/iXSxc6bnANk/maxresdefault.jpg")!,
                                               coordinates: CLLocation(latitude: 0, longitude: 0))
        return FurgoperfectosDetailView(state: viewModel)
    }
}
