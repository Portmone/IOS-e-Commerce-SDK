//
//  AlertPresentable.swift
//  PortmoneSDK-Example
//
//  Created on 4/4/19.
//  Copyright © 2019 Portmone. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.

//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.

import UIKit

protocol AlertPresentable {
    
}

extension AlertPresentable where Self: UIViewController {
    
    typealias ButtonHandler = (UIAlertAction) -> Void
    typealias OptionalComplition = (() -> Void)?
    
    // Default "Cancel" action
    private var cancelAction: UIAlertAction {
        return UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    }
    
    // MARK: Private methods
    private func createAlert(with title: String?,
                             message: String?,
                             preferredStyle: UIAlertController.Style,
                             actions: [UIAlertAction]) -> UIAlertController {
        
        let controller = UIAlertController(title: title,
                                           message: message,
                                           preferredStyle: preferredStyle)
        //controller.view.tintColor = Constants
        controller.modalPresentationStyle = .overFullScreen
        actions.forEach { controller.addAction($0) }
        return controller
    }
    
    // Informative simple alert with one "OK" button and without handler.
    func presentAlert(title: String,
                      message: String?,
                      handler: ButtonHandler? = nil) {
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: handler)
        let controller = createAlert(with: title,
                                     message: message,
                                     preferredStyle: .alert,
                                     actions: [okAction])
        present(controller, animated: true)
    }
}
