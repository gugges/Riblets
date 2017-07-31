//
//  OKRootRouter.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

final class OKRootRouter: OKRouter {
    
    unowned let appDelegate: AppDelegate
    
    init(interactor: OKInteractor, appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
        super.init(interactor: interactor)
        self.appDelegate.appDelegateHandler = rootInteractor()
    }
    
    override func present(childRouter: OKRouter, animated: Bool) {
        attach(childRouter: childRouter)
        
        if let childVC = childRouter.interactor.presenter?.viewController {
            appDelegate.present(viewController: childVC, animated: animated)
        }
    }
    
    //MARK: - Helpers
    
    fileprivate func rootInteractor() -> OKRootInteractor? {
        return interactor as? OKRootInteractor
    }
    
}
