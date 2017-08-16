//
//  LocationParser.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 7/26/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

struct OKLocationParser: OKParser {
    
    func parse(from dictionary: [AnyHashable : Any]) -> OKLocation? {
        guard
            let cityName = dictionary["city_name"] as? String,
            let stateCode = dictionary["state_code"] as? String
            else {
                return nil
        }
        
        return OKLocation(cityName: cityName, stateCode: stateCode)
    }
    
}
