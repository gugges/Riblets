//
//  OKNetworkClientResult.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/26/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

enum OKNetworkClientResult<T> {
    case success(T)
    case failure(Error?)
}
