//
//  MapModel.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 04/03/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import CoreLocation

final class FurgoperfectoDataModel: Codable  {

    let id, icono, nombre, lat, lng, html, htmlp: String?
    let link: String?
    let imagen: String?
    let autor, ancho, alto, destomtom: String?
    let idMember: String?
    let topicID, body: String?

    var generatedCountry: String?
    var generatedCity: String?
    var generatedAddress: String?

    enum CodingKeys: String, CodingKey {
        case id, icono, nombre, lat, lng, html, htmlp, link, imagen, autor, ancho, alto, destomtom
        case idMember = "id_member"
        case topicID = "topic_id"
        case body
    }
}
