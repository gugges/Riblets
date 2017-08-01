//
//  OKImageNetworkManagerProtocol.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/31/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

protocol OKImageNetworkManagerProtocol {
    func request(url: URL, callback: @escaping (UIImage?) -> Void) -> URLSessionDataTask
}
