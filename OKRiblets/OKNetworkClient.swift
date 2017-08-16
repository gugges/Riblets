//
//  OKNetworkClient.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 7/26/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import Foundation

protocol OKNetworkClient {
    var basePath: String { get }
    func request(method: OKNetworkClientRequestMethod, path: String, parameters: [String : Any]?, completion: @escaping (OKNetworkClientResult<Any>) -> Void)
}
