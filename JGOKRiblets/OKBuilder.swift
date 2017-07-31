//
//  OKBuilder.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

protocol OKBuilder {
    associatedtype C
    associatedtype T
    
    static func build(with context: C?) -> T
}
