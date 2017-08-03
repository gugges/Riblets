//
//  OKNavigationController.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/31/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

final class OKNavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        guard let viewController = super.popViewController(animated: animated) else {
            return nil
        }
        
        if let viewController = viewController as? OKViewController {
            _ = viewController.presenter?.interactor?.router?.detachFromParent()
        }
        
        return viewController
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        guard let viewControllers = super.popToRootViewController(animated: animated) else {
            return nil
        }
        
        for viewController in viewControllers {
            if let viewController = viewController as? OKViewController {
                _ = viewController.presenter?.interactor?.router?.detachFromParent()
            }
        }
        
        return viewControllers
    }
}
