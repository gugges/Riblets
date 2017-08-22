//
//  OKMatchSearchBuilder.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

struct OKMatchSearchBuilder: OKBuilder {
    
    static func build(components: OKMatchSearchComponents) -> OKMatchSearchRouter {
        let viewController = OKMatchSearchViewController()
        let presenter = OKMatchSearchPresenter(viewController: viewController)
        let interactor = OKMatchSearchInteractor(presenter: presenter, networkManager: components.networkManager)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        
        return OKMatchSearchRouter(interactor: interactor)
    }
    
}
