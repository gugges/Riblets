//
//  UICollectionViewCell+Util.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 8/2/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    static var reuseID: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
