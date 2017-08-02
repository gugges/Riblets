//
//  OKLaunchBuilder.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/24/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

struct OKLaunchBuilder: OKBuilder {

    static func build(components: Any?) -> OKRouter {
        let viewController = OKViewController()
        viewController.view.backgroundColor = .colorBlue3()
        return OKRouter(interactor: OKInteractor(presenter: OKPresenter(viewController: viewController)))
    }
    
}
