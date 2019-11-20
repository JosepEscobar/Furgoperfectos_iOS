//
//  DetailFurgoperfectoInteractor.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 03/11/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

import UIKit

protocol DetailFurgoperfectoBusinessLogic {
    func doSomething(request: DetailFurgoperfecto.Something.Request)
}

protocol DetailFurgoperfectoDataStore {
    //var name: String { get set }
}

class DetailFurgoperfectoInteractor: DetailFurgoperfectoBusinessLogic, DetailFurgoperfectoDataStore {
    var presenter: DetailFurgoperfectoPresentationLogic?
    var worker: DetailFurgoperfectoWorker?
    //var name: String = ""

    // MARK: Do something

    func doSomething(request: DetailFurgoperfecto.Something.Request) {
        worker = DetailFurgoperfectoWorker()
        worker?.doSomeWork()

        let response = DetailFurgoperfecto.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
