//
//  UIViewController+Util.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 8/5/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func ok_navigationController() -> UINavigationController? {
        if let navigationController = self as? OKNavigationController {
            return navigationController
        }
        
        return self.navigationController
    }
    
    func ok_viewController() -> UIViewController? {
        if let navigationController = self as? OKNavigationController {
            return navigationController.topViewController
        }
        
        return self
    }
}
