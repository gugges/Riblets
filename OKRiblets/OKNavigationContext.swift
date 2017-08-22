//
//  OKNavigationContext.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 8/21/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

class OKNavigationContext {

    let router: OKRouter
    var viewController: UIViewController

    init?(router: OKRouter, isNavigationController: Bool) {
        guard let viewController = router.viewController else {
            return nil
        }

        self.router = router
        self.viewController = isNavigationController ? OKNavigationController(rootViewController: viewController) : viewController
    }

}
