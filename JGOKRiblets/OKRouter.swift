//
//  OKRouter.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

protocol OKRouterProtocol: class {
    func attach(childRouter: OKRouter)
    func detach(childRouter: OKRouter) -> OKRouter?
    func dismiss(childRouter: OKRouter)
    func present(childRouter: OKRouter, animated: Bool)
    func push(childRouter: OKRouter, animated: Bool)
}

class OKRouter: NSObject, OKRouterProtocol {
    
    weak var parent: OKRouter?
    
    let interactor: OKInteractor
    lazy var childRouters = Set<OKRouter>()
    
    //MARK: - Lifecycle
    
    init(interactor: OKInteractor) {
        self.interactor = interactor
        super.init()
        self.interactor.router = self
    }
    
    //MARK: - Child Router
    
    func attach(childRouter: OKRouter) {
        childRouter.parent = self
        childRouters.insert(childRouter)
    }
    
    func detach(childRouter: OKRouter) -> OKRouter? {
        return childRouters.remove(childRouter)
    }
 
    //MARK: - OKRouterProtocol
    
    func dismiss(childRouter: OKRouter) {
        let childRouter = detach(childRouter: childRouter)
        childRouter?.VC()?.dismiss(animated: true, completion: nil)
    }
    
    func present(childRouter: OKRouter, animated: Bool) {
        
    }
    
    func push(childRouter: OKRouter, animated: Bool) {
        attach(childRouter: childRouter)
        
        guard let childVC = childRouter.VC() else {
            return
        }
        
        if let currentVC = VC() as? UINavigationController  {
            currentVC.pushViewController(childVC, animated: true)
            
        } else if let navController = VC()?.navigationController {
            navController.pushViewController(childVC, animated: true)
        }
    }
    
    //MARK: - Helpers
    
    func presentProfile(with user: OKUser) {
        
    }
    
    func VC() -> UIViewController? {
        return interactor.presenter?.viewController
    }
}
