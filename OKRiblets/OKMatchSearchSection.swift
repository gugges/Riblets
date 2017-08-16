//
//  OKMatchSearchSection.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 8/5/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

enum OKMatchSearchSection: Int {
    case user
    case loading
    case unknown
    
    init(rawValue: Int) {
        switch rawValue {
        case 0:
            self = .user
        case 1:
            self = .loading // .loading must be highest known index
        default:
            self = .unknown
        }
    }
}
