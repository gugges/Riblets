//
//  OKMatchSearchSizingFactory.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 8/5/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

fileprivate let kUserSpacing: CGFloat = 16

struct OKMatchSearchSizingFactory: OKMatchSearchSizingFactoryProtocol {
 
    func sizeForLoadingCell(with collectionView: UICollectionView) -> CGSize {
        let itemsPerRow: CGFloat = 1
        
        let insets = sectionInsets(for: .loading)
        let spacing = itemSpacing(for: .loading)
        
        let hMarginsAndInsets: CGFloat = insets.left + insets.right + spacing * (itemsPerRow - 1)
        let width: CGFloat = floor((collectionView.frame.width - hMarginsAndInsets) / itemsPerRow)
        
        return CGSize(width: width, height: 70)
    }
    
    func sizeForUserCell(with collectionView: UICollectionView) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let itemsPerColumn: CGFloat = 2
        
        let insets = sectionInsets(for: .user)
        let spacing = itemSpacing(for: .user)
        
        let hMarginsAndInsets: CGFloat = insets.left + insets.right + spacing * (itemsPerRow - 1)
        let vMarginsAndInsets: CGFloat = insets.top + insets.bottom + spacing * (itemsPerRow - 1)
        
        let width: CGFloat = floor((collectionView.frame.width - hMarginsAndInsets) / itemsPerRow)
        let height: CGFloat = floor((collectionView.frame.height - vMarginsAndInsets) / itemsPerColumn)
        
        return CGSize(width: width, height: height)
    }
    
    func sectionInsets(for section: OKMatchSearchSection) -> UIEdgeInsets {
        switch section {
        case .user:
            return UIEdgeInsets(top: kUserSpacing, left: kUserSpacing, bottom: kUserSpacing, right: kUserSpacing)
            
        case .loading:
            return UIEdgeInsets(top: 0, left: 0, bottom: kUserSpacing, right: 0)
            
        default:
            return .zero
        }
    }
    
    func itemSpacing(for section: OKMatchSearchSection) -> CGFloat {
        switch section {
        case .user:
            return kUserSpacing
            
        default:
            return 0
        }
    }
}
