//
//  APIEndpoints.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 04/03/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import Foundation

let apiUrl: String = "https://www.furgovw.org/api.php"
let apiGetEverything = apiUrl + "?getEverything="
let apiGetEverithingLight = apiUrl + "?getEverything=&withoutBody="
let apiGetNearby = apiUrl + "?latitude=%0&longitude=%1"
