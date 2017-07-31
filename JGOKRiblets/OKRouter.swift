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
        attach(childRouter: childRouter)
        
        if let currentVC = VC(), let childVC = childRouter.VC() {
            currentVC.present(childVC, animated: animated)
        }
    }
    
    //MARK: - Helpers
    
    func presentProfile(with user: OKUser) {
        
    }
    
    func VC() -> UIViewController? {
        return interactor.presenter?.viewController
    }
}
