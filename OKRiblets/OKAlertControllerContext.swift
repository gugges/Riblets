//
//  OKAlertControllerContext.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 8/5/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

struct OKAlertControllerContext {
    let title: String?
    let subtitle: String?
    let preferredStyle: UIAlertControllerStyle
    let actions: [OKAlertActionContext]
}

struct OKAlertActionContext {
    let title: String
    let style: UIAlertActionStyle
    let handler: ((UIAlertAction) -> Void)?
}
