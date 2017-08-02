//
//  OKRootBuilder.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

struct OKRootBuilder: OKBuilder {

    static func build(components: AppDelegate?) -> OKRootRouter {
        guard let components = components else {
            fatalError("Root builder requires AppDelegate context")
        }
        
        let interactor = OKRootInteractor(presenter: nil)
        
        return OKRootRouter(interactor: interactor, appDelegate: components)
    }
    
}
