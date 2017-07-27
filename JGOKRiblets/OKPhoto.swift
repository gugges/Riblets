//
//  OKPhoto.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/26/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

struct OKPhoto {
    let id: String
    let largeUrl: URL
}

extension OKPhoto: Equatable {
    
    static func == (lhs: OKPhoto, rhs: OKPhoto) -> Bool {
        return lhs.id == rhs.id && lhs.largeUrl == rhs.largeUrl
    }
}
