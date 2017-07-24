//
//  OKRootBuilder.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

final class OKRootBuilder: OKBuilder {

    override class func build() -> OKRootRouter {
        return OKRootRouter(interactor: OKRootInteractor(presenter: nil))
    }
    
}
