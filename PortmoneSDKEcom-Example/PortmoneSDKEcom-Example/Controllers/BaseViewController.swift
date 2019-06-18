//
//  BaseViewController.swift
//  PortmoneSDKEcom-Example
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

class BaseViewController: UIViewController, AlertPresentable {
    
    private var tapGesture: UITapGestureRecognizer?
    
    var style = StyleSourceObject()

    var scrollView: UIScrollView? {
        return nil
    }
    
    var child: BaseViewController? {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: Controller life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideKeyboardWhenTappedAround()
        registerNotificationObservers()
        setInitialInsets()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeNotificationObservers()
        removeDismissTap()

        super.viewWillDisappear(animated)
    }
    
    private func setInitialInsets() {
        scrollView?.contentInset = .zero
        scrollView?.scrollIndicatorInsets = .zero
    }
}

extension BaseViewController {
    private func registerNotificationObservers() {
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func removeNotificationObservers() {
        removeDismissTap()
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let size = keyboardFrame.cgRectValue.size
        var keyboardHeight: CGFloat
        if #available(iOS 11.0, *) {
            keyboardHeight = size.height - view.safeAreaInsets.bottom
        } else {
            keyboardHeight = size.height
        }
        
        let inset = UIEdgeInsets(top: 0,
                                 left: 0,
                                 bottom: keyboardHeight,
                                 right: 0)
        scrollView?.contentInset = inset
        scrollView?.scrollIndicatorInsets = inset
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        setInitialInsets()
    }
    
    @IBAction private func styleButtonClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "style", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "style") {
            let navController = segue.destination as? UINavigationController
            let controller = navController?.viewControllers.first as? StyleViewController
            controller?.delegate = child
            controller?.styleModel = style.model
        }
    }
}

extension BaseViewController {
    private func hideKeyboardWhenTappedAround() {
        let dismissTap = UITapGestureRecognizer(target: self,
                                                action: #selector(dismissKeyboard))
        dismissTap.cancelsTouchesInView = true
        view.addGestureRecognizer(dismissTap)
        tapGesture = dismissTap
    }
    
    private func removeDismissTap() {
        guard let tap = tapGesture else {
            return
        }
        view.removeGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// self <-- StyleViewController
extension BaseViewController: StyleViewControllerDelegate {
    func finishEdit(model: StyleModel) {
        style.model = model
    }
}
