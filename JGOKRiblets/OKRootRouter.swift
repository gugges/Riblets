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
    fileprivate var Interactor: OKRootInteractor? {  return interactor as? OKRootInteractor }
    
    init(interactor: OKInteractor, appDelegate: AppDelegate) {
        self.appDelegate = appDelegate
        super.init(interactor: interactor)
        self.appDelegate.appDelegateHandler = Interactor
    }
    
    override func push(childRouter: OKRouter, animated: Bool) {
        attach(childRouter: childRouter)
        
        if let childViewController = childRouter.ViewController {
            appDelegate.root(viewController: childViewController, animated: animated)
        }
    }
    
}
