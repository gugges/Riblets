//
//  OKRootRouter.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

protocol OKRootRouterDelegate: class {
    func present(viewController: UIViewController, animated: Bool)
}

final class OKRootRouter: OKRouter {
    
    override init(interactor: OKInteractor) {
        super.init(interactor: interactor)
        interactor.delegate = self
    }

    weak var delegate: OKRootRouterDelegate?
    
    //MARK: - Helpers
    
    fileprivate func rootInteractor() -> OKRootInteractor? {
        return interactor as? OKRootInteractor
    }
    
}

//MARK: - OKAppDelegate

extension OKRootRouter: OKAppDelegate {
    
    func didFinishLaunching(with launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        rootInteractor()?.didFinishLaunching(with: launchOptions)
    }
    
    func application(continue userActivity: NSUserActivity) -> Bool {
        return rootInteractor()?.application(continue: userActivity) ?? false
    }
    
}

//MARK: - OKInteractorDelegate

extension OKRootRouter: OKInteractorDelegate {
    
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
