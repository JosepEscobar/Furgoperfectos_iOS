//
//  UIViewControllerExtensions.swift
//  VanLife
//
//  Created by Josep Escobar on 27/07/2020.
//  Copyright © 2020 Josep Escobar. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
class func getCurrentVC() -> UIViewController? {
var result: UIViewController?
var window = UIApplication.shared.windows.first { $0.isKeyWindow }
        if window?.windowLevel != UIWindow.Level.normal {
            let windows = UIApplication.shared.windows
            for tmpWin in windows {
                if tmpWin.windowLevel == UIWindow.Level.normal {
                    window = tmpWin
                    break
                }
            }
        }
        let fromView = window?.subviews[0]
        if let nextRespnder = fromView?.next {
            if nextRespnder.isKind(of: UIViewController.self) {
                result = nextRespnder as? UIViewController
                result?.navigationController?.pushViewController(result!, animated: false)
            } else {
                result = window?.rootViewController
            }
        }
        return result
    }
}
