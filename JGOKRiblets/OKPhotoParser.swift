//
//  OKPhotoParser.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/26/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

struct OKPhotoParser: OKParser {
    
    func parse(from dictionary: [AnyHashable : Any]) -> OKPhoto? {
        guard
            let id = dictionary["id"] as? String,
            let fullPaths = dictionary["full_paths"] as? [String: String],
            let largePath = fullPaths["large"],
            let largeUrl = URL(string: largePath)
            else {
                return nil
        }
        
        return OKPhoto(id: id, largeUrl: largeUrl)
    }
}
