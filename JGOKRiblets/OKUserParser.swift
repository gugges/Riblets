//
//  OKUserParser.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/26/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

struct OKUserParser: OKParser {
    
    fileprivate let photoParser: OKPhotoParser
    fileprivate let locationParser: OKLocationParser
    
    init() {
        photoParser = OKPhotoParser()
        locationParser = OKLocationParser()
    }
    
    func parse(from dictionary: [AnyHashable : Any]) -> OKUser? {
        guard
            let id = dictionary["userid"] as? String,
            let username = dictionary["username"] as? String,
            let age = dictionary["age"] as? Int,
            let match = dictionary["match"] as? Int,
            let isOnline = dictionary["is_online"] as? Bool,
            let photoDictionary = dictionary["photo"] as? [String: Any],
            let photo = photoParser.parse(from: photoDictionary),
            let locationDictionary = dictionary["location"] as? [String: Any],
            let location = locationParser.parse(from: locationDictionary)
            else {
                return nil
        }
        
        return OKUser(id: id, username: username, age: age, isOnline: isOnline, match: match, photo: photo, location: location)
    }
    
}
