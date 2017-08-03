//
//  UICollectionViewCell+Util.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 8/2/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    static func reuseID() -> String {
        return String(describing: self)
    }
}
