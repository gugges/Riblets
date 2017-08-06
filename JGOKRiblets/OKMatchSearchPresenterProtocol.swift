//
//  OKMatchSearchPresenterProtocol.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 8/5/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

protocol OKMatchSearchPresenterProtocol {
    func add(users: [OKUser])
    func display(error: Error?)
}
