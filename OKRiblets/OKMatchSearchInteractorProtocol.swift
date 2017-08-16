//
//  OKMatchSearchInteractorProtocol.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 8/5/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

protocol OKMatchSearchInteractorProtocol: class {
    func reloadMatches()
    func nextPage()
    func selected(user: OKUser)
}
