//
//  MapModel.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 04/03/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import UIKit

class FurgoperfectoModel: NSObject, Codable {
    
    var id: String?
    var icono: String?
    var nombre: String?
    var lat: String?
    var lng: String?
    var html: String?
    var htmlp: String?
    var link: String?
    var imagen: String?
    var autor: String?
    var ancho: String?
    var alto: String?
    var destomtom: String?
    var id_member: String?
    var date:String?
    var topic_id: String?
    var body:String?
    
    init(id: String?, icono: String?, nombre: String?, lat: String?, lng: String?, html: String?, htmlp: String?, link: String?, imagen: String?, autor: String?, ancho: String?, alto: String?, destomtom: String?, id_member: String?, date: String?, topic_id: String?, body: String?) {
        
        self.id = id
        self.icono = icono
        self.nombre = nombre
        self.lat = lat
        self.lng = lng
        self.html = html
        self.htmlp = htmlp
        self.link = link
        self.imagen = imagen
        self.autor = autor
        self.ancho = ancho
        self.alto = alto
        self.destomtom = destomtom
        self.id_member = id_member
        self.date = date
        self.topic_id = topic_id
        self.body = body
        
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case icono
        case nombre
        case lat
        case lng
        case html
        case htmlp
        case link
        case imagen
        case autor
        case ancho
        case alto
        case destomtom
        case id_member
        case date
        case topic_id
        case body
    }
}
