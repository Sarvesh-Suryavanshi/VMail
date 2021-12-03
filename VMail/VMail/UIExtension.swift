//
//  UIExtension.swift
//  VMail
//
//  Created by Sarvesh Suryavanshi on 02/12/21.
//

import UIKit

extension UIViewController {
    
    func embedInNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.navigationBar.tintColor = .black
        return navigationController
    }
}
