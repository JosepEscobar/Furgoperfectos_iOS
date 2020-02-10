//
//  DetailFurgoperfectoViewController.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 03/11/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

import UIKit

protocol DetailFurgoperfectoDisplayLogic: class {
    func displaySomething(viewModel: DetailFurgoperfecto.Something.ViewModel)
}

final class DetailFurgoperfectoViewController: UIViewController, DetailFurgoperfectoDisplayLogic {
    var interactor: DetailFurgoperfectoBusinessLogic?
    var router: (NSObjectProtocol & DetailFurgoperfectoRoutingLogic & DetailFurgoperfectoDataPassing)?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = DetailFurgoperfectoInteractor()
        let presenter = DetailFurgoperfectoPresenter()
        let router = DetailFurgoperfectoRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }

    // MARK: Do something

    //@IBOutlet weak var nameTextField: UITextField!

    func doSomething() {
        let request = DetailFurgoperfecto.Something.Request()
        interactor?.doSomething(request: request)
    }

    func displaySomething(viewModel: DetailFurgoperfecto.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
