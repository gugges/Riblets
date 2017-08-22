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
    weak var viewController: UIViewController? { return interactor.presenter?.viewController }
    weak var navigationController: UINavigationController? { return viewController?.navigationController }
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
        childRouter?.viewController?.dismiss(animated: true, completion: nil)
    }
    
    func present(childRouter: OKRouter, animated: Bool) {
        if let childViewController = childRouter.viewController {
            attach(childRouter: childRouter)
            viewController?.present(childViewController, animated: true, completion: nil)
            
        } else {
            fatalError("Cannot present child router without viewController")
        }
    }
    
    func push(childRouter: OKRouter, animated: Bool) {
        guard let childViewController = childRouter.viewController else {
            fatalError("Cannot push child router without viewController")
        }

        guard let navigationController = navigationController else {
            fatalError("Cannot push child router without navigationController")
        }

        attach(childRouter: childRouter)
        navigationController.pushViewController(childViewController, animated: true)
    }


    func setRoot(navigationContext: OKNavigationContext, animated: Bool) {
        fatalError("setRoot(navigationRouter:) not implemented")
    }
}
