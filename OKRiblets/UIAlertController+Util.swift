//
//  UIAlertController+Util.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 8/5/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

extension UIAlertController {

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelAlert
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal
    }
}
