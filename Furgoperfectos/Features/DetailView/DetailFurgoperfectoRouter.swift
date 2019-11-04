//
//  DetailFurgoperfectoRouter.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 03/11/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

import UIKit

@objc protocol DetailFurgoperfectoRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol DetailFurgoperfectoDataPassing {
    var dataStore: DetailFurgoperfectoDataStore? { get }
}

class DetailFurgoperfectoRouter: NSObject, DetailFurgoperfectoRoutingLogic, DetailFurgoperfectoDataPassing {
    weak var viewController: DetailFurgoperfectoViewController?
    var dataStore: DetailFurgoperfectoDataStore?

    // MARK: Routing

    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}

    // MARK: Navigation

    //func navigateToSomewhere(source: DetailFurgoperfectoViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: DetailFurgoperfectoDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
