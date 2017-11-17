//
//  AlertController.swift
//  iOSBooksProjecs
//
//  Created by Mac User on 5/2/17.
//  Copyright © 2017 Cookie. All rights reserved.
//

import Foundation
import UIKit

public class UIAlertControllerWindow: UIAlertController {
    
    lazy var alertWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = StatusBarViewController()
        window.backgroundColor = UIColor.clear
        return window
    }()
    
    public func show(animated: Bool = true, completion: (() -> Void)? = nil) {
        if let rootViewController = alertWindow.rootViewController {
            alertWindow.makeKeyAndVisible()
            
            rootViewController.present(self, animated: animated, completion: completion)
        }
    }
    
//    override func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
//        dismiss(animated: animated, completion: completion)
//    }
    
    deinit {
        alertWindow.isHidden = true
    }
}

private class StatusBarViewController: UIViewController {
    
    private func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIApplication.shared.statusBarStyle
    }
    
    private func prefersStatusBarHidden() -> Bool {
        return UIApplication.shared.isStatusBarHidden
    }
}
