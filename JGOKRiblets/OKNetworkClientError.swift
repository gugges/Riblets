//
//  OKNetworkClientError.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/26/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

enum OKNetworkClientError: Error {
    case malformedURL
    case invalidJSON
    case unparsableModel
}
