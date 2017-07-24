//
//  OKBuilder.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

class OKBuilder {
    
    class func build() -> OKRouter {
        let viewController = OKViewController()
        let presenter = OKPresenter(viewController: viewController)
        let interactor = OKInteractor(presenter: presenter)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        
        return OKRouter(interactor: interactor)
    }
    
}
