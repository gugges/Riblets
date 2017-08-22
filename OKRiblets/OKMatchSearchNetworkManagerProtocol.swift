//
//  OKMatchSearchNetworkManagerProtocol.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 8/21/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

protocol OKMatchSearchNetworkManagerProtocol: class {
    init(client: OKNetworkClient)
    func getMatches(completion: @escaping (OKNetworkClientResult<[OKUser]>) -> Void)
}
