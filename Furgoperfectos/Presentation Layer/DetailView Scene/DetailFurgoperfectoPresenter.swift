//
//  DetailFurgoperfectoPresenter.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 03/11/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

import UIKit

protocol DetailFurgoperfectoPresentationLogic {
    func presentSomething(response: DetailFurgoperfecto.Something.Response)
}

class DetailFurgoperfectoPresenter: DetailFurgoperfectoPresentationLogic {
    weak var viewController: DetailFurgoperfectoDisplayLogic?

    // MARK: Do something

    func presentSomething(response: DetailFurgoperfecto.Something.Response) {
        let viewModel = DetailFurgoperfecto.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
