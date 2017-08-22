//
//  OKRootRouter.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

final class OKRootRouter: OKRouter {
    
    unowned let appDelegate: AppDelegate
    fileprivate var rootInteractor: OKRootInteractor? {  return interactor as? OKRootInteractor }
    
    init(interactor: OKInteractor, appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
        super.init(interactor: interactor)
        self.appDelegate.appDelegateHandler = rootInteractor
    }

    override func setRoot(navigationContext: OKNavigationContext, animated: Bool) {
        attach(childRouter: navigationContext.router)
        appDelegate.setRoot(viewController: navigationContext.viewController, animated: animated)
    }
    
}
