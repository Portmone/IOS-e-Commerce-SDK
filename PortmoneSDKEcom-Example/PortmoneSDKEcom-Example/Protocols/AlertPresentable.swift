//
//  AlertPresentable.swift
//  PortmoneSDK-Example
//
//  Created by Oleg Pankiv on 12/27/18.
//  Copyright © 2018 Devlight. All rights reserved.
//

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
