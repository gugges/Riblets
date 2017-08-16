//
//  OKLaunchBuilder.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 7/24/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

struct OKLaunchBuilder: OKBuilder {

    static func build(components: Any?) -> OKRouter {
        return OKRouter(interactor: OKInteractor(presenter: OKPresenter(viewController: OKLaunchViewController())))
    }
    
}
