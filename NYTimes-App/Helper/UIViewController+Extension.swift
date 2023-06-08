//
//  UIViewController+Extension.swift
//  NYTimes-App
//
//  Created by Shiv Vaishnav on 08/06/23.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    func showIndicator(animated: Bool = true) {
        MBProgressHUD.showAdded(to: self.view, animated: animated)
    }

    func hideIndicator(animated: Bool = true) {
        MBProgressHUD.hide(for: self.view, animated: animated)
    }

    func showAlert(
        title: String? = NSLocalizedString("Error", comment: ""),
        message: String?,
        okButton: String? = NSLocalizedString("OK", comment: "")
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: okButton, style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}

extension UIViewController {
    class func instantiate<T: UIViewController>(
        storyboardName: String,
        vcIdentifier: String? = nil,
        bundleClass: AnyClass
    ) -> T? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: bundleClass))
        let identifier = vcIdentifier ?? String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as? T
    }
}

extension UIViewController {
    func initializeWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = self
        return window
    }
}
