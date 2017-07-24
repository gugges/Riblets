//
//  OKRouter.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

class OKRouter: OKHashable {
    
    let interactor: OKInteractor
    var childRouters = Set<OKRouter>()
    
    init(interactor: OKInteractor) {
        self.interactor = interactor
    }
    
    func attach(childRouter: OKRouter) {
        childRouters.insert(childRouter)
    }
    
    func removeRouter<T>(type: T.Type) -> OKRouter? where T: OKRouter {
        for router in childRouters {
            if router === type  {
                return childRouters.remove(router)
            }
        }
        return nil
    }
    
}
