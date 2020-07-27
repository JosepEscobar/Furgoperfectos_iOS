//
//  UIAlertControllerExtensions.swift
//  VanLife
//
//  Created by Josep Escobar on 27/07/2020.
//  Copyright © 2020 Josep Escobar. All rights reserved.
//

import UIKit
import Foundation

extension UIAlertController {
    //Setting our Alert ViewController, presenting it.
    func presentAlert() {
        UIViewController.getCurrentVC()?.present(self, animated: true, completion: nil)
    }

    func dismissAlert() {
        UIViewController.getCurrentVC()?.dismiss(animated: true, completion: nil)
    }
}
