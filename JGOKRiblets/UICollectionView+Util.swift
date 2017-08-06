//
//  UICollectionView+Util.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/31/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier \(T.reuseID)")
        }
        
        return cell
    }
    
}
