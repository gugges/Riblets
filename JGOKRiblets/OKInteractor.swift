//
//  OKInteractor.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

class OKInteractor {
    
    let presenter: OKPresenter?
    weak var router: OKRouter?
    
    init(presenter: OKPresenter?) {
        self.presenter = presenter
    }
 
    //MARK: - Helpers
    
    func presentProfile(with user: OKUser) {
        
    }
    
}
