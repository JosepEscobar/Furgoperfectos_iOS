//
//  FurgoperfectoRowView.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 26/07/2020.
//  Copyright © 2020 Josep Escobar. All rights reserved.
//

import SwiftUI

struct FurgoperfectoRowView: View {
    let imageURL: URL
    let name: String
    let distance: String
    
    enum Constant {
        static let loadingMessage = "Cargando..."
    }
    
    var body: some View {
        HStack {
            AsyncImage(
                url: imageURL,
                placeholder: Text(Constant.loadingMessage)
            ).aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 100)
                .padding(.trailing)
            VStack(alignment: .leading) {
                Text(name)
                Text("A \(distance)km de tí")
                    .foregroundColor(Color.gray)
            }
            
        }
    }
}

struct FurgoperfectoRowView_Previews: PreviewProvider {
    static var previews: some View {
        FurgoperfectoRowView(imageURL: URL(string: "https://image.tmdb.org/t/p/original//pThyQovXQrw2m0s9x82twj48Jq4.jpg")!, name: "Test", distance: "3300")
    }
}
