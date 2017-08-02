//
//  OKMatchSearchBuilder.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

struct OKMatchSearchBuilder: OKBuilder {
    
    static func build(components: Bool?) -> OKMatchSearchRouter {
        let isNavController = components ?? true
        let viewController = OKMatchSearchViewController()
        let navigationController = isNavController ? OKNavigationController(rootViewController: viewController) : viewController
        let presenter = OKMatchSearchPresenter(viewController: navigationController)
        let interactor = OKMatchSearchInteractor(presenter: presenter)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        
        return OKMatchSearchRouter(interactor: interactor)
    }
    
}
