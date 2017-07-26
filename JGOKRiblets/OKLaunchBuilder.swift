//
//  OKLaunchBuilder.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/24/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

struct OKLaunchBuilder: OKBuilder {

    static func build() -> OKRouter {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .lightGray
        return OKRouter(interactor: OKInteractor(presenter: OKPresenter(viewController: viewController)))
    }
    
}
