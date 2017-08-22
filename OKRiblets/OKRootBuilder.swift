//
//  OKRootBuilder.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

struct OKRootBuilder: OKBuilder {

    static func build(components: AppDelegate) -> OKRootRouter {        
        let interactor = OKRootInteractor(presenter: nil)
        return OKRootRouter(interactor: interactor, appDelegate: components)
    }
    
}
