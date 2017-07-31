//
//  OKPresenter.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

class OKPresenter: NSObject {
    
    let viewController: UIViewController
    weak var interactor: OKInteractor?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
}
