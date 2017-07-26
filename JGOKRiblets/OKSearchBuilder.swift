//
//  OKSearchBuilder.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

struct OKSearchBuilder: OKBuilder {
    
    static func build() -> OKSearchRouter {
        let viewController = OKSearchViewController()
        let presenter = OKSearchPresenter(viewController: viewController)
        let interactor = OKSearchInteractor(presenter: presenter)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        
        return OKSearchRouter(interactor: interactor)
    }
    
}
