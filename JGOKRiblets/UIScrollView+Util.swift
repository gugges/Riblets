//
//  UIScrollView+Util.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/31/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func pagesRemaining(scrollDirection: UICollectionViewScrollDirection = .vertical) -> CGFloat {
        let isVertical = scrollDirection == .vertical
        let viewSize = isVertical ? contentSize.height : contentSize.width
        let currentOffset = isVertical ? contentOffset.y : contentOffset.x
        let frameSize = isVertical ? frame.height : frame.width
        
        return max(((viewSize - currentOffset) / frameSize) - 1, 0)
    }
}
