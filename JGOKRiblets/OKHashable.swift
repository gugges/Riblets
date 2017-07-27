//
//  OKHashable.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

class OKHashable {}

//MARK: - Hashable

extension OKHashable: Hashable {
    
    var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
}

//MARK: - Equatable

extension OKHashable: Equatable {
    
    static func ==(lhs: OKHashable, rhs: OKHashable) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}
