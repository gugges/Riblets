//
//  OKParser.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 7/26/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

protocol OKParser {
    associatedtype T
    func parse(from dictionary: [AnyHashable: Any]) -> T?
}
