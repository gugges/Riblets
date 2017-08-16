//
//  OKLocation.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 7/26/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

struct OKLocation {
    let cityName: String
    let stateCode: String
}

extension OKLocation: Equatable {
    
    static func == (lhs: OKLocation, rhs: OKLocation) -> Bool {
        return lhs.cityName == rhs.cityName && lhs.stateCode == rhs.stateCode
    }
}
