//
//  OKRouter.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

protocol OKRouterProtocol: class {
    func attach(childRouter: OKRouter)
    func detach(childRouter: OKRouter) -> OKRouter?
    func detachFromParent() -> OKRouter?
    func dismiss(childRouter: OKRouter)
    func present(childRouter: OKRouter, animated: Bool)
    func push(childRouter: OKRouter, animated: Bool)
}

class OKRouter: NSObject, OKRouterProtocol {
    
    let interactor: OKInteractor
    var ViewController: UIViewController? { return interactor.presenter?.viewController }
    
    weak var parent: OKRouter?
    lazy var childRouters = Set<OKRouter>()
    
    //MARK: - Lifecycle
    
    init(interactor: OKInteractor) {
        self.interactor = interactor
        super.init()
        self.interactor.router = self
    }
    
    //MARK: - OKRouterProtocol
    
    func attach(childRouter: OKRouter) {
        childRouter.parent = self
        childRouters.insert(childRouter)
    }
    
    func detach(childRouter: OKRouter) -> OKRouter? {
        return childRouters.remove(childRouter)
    }
    
    func detachFromParent() -> OKRouter? {
        return parent?.detach(childRouter: self)
    }
    
    func dismiss(childRouter: OKRouter) {
        let childRouter = detach(childRouter: childRouter)
        childRouter?.ViewController?.dismiss(animated: true, completion: nil)
    }
    
    func present(childRouter: OKRouter, animated: Bool) {
        if let childViewController = childRouter.ViewController {
            attach(childRouter: childRouter)
            ViewController?.present(childViewController, animated: true, completion: nil)
            
        } else {
            fatalError("Cannot present child router without viewController")
        }
    }
    
    func push(childRouter: OKRouter, animated: Bool) {
        guard let childViewController = childRouter.ViewController else {
            fatalError("Cannot push child router without viewController")
        }
        
        if let navigationController = ViewController?.ok_navigationController() {
            attach(childRouter: childRouter)
            navigationController.pushViewController(childViewController, animated: true)
            
        } else {
            fatalError("Cannot push child router without navigationController")
        }
    }
    
}
