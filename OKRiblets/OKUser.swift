//
//  OKUser.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 7/26/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

struct OKUser {
    let id: String
    let username: String
    let age: Int
    let isOnline: Bool
    let match: Int
    let photo: OKPhoto
    let location: OKLocation
}

extension OKUser: Equatable {
    
    static func == (lhs: OKUser, rhs: OKUser) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.username == rhs.username &&
            lhs.age == rhs.age &&
            lhs.isOnline == rhs.isOnline &&
            lhs.match == rhs.match &&
            lhs.photo == rhs.photo &&
            lhs.location == rhs.location
    }
}
