//
//  OKInteractor.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

protocol OKInteractorDelegate: class {
    func present(router: OKRouter)
    func dismiss(routerType: OKRouter.Type)
}

class OKInteractor {
    
    let presenter: OKPresenter?
    weak var delegate: OKInteractorDelegate?
    
    init(presenter: OKPresenter?) {
        self.presenter = presenter
    }
    
}
