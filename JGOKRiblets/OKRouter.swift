//
//  OKRouter.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

protocol OKRouterDelegate: class {
    func present(viewController: UIViewController, animated: Bool)
}

class OKRouter: OKHashable {
    
    weak var parent: OKRouter?
    weak var delegate: OKRouterDelegate?
    
    let interactor: OKInteractor
    lazy var childRouters = Set<OKRouter>()
    
    init(interactor: OKInteractor) {
        self.interactor = interactor
        super.init()
        interactor.delegate = self
    }
    
    func attach(childRouter: OKRouter) {
        childRouter.parent = self
        childRouters.insert(childRouter)
    }
    
    func removeRouter(type: OKRouter.Type) -> OKRouter? {
        for router in childRouters {
            if type(of: router) == type  {
                return childRouters.remove(router)
            }
        }
        return nil
    }
    
}

//MARK: - OKInteractorDelegate

extension OKRouter: OKInteractorDelegate {
    
    func dismiss(routerType: OKRouter.Type) {
        _ = removeRouter(type: routerType)
    }
    
    func present(router: OKRouter) {
        attach(childRouter: router)
        
        if let viewController = router.interactor.presenter?.viewController {
            delegate?.present(viewController: viewController, animated: true)
        }
    }
    
}
