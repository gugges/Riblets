//
//  OKMatchSearchSizingFactoryProtocol.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 8/5/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

protocol OKMatchSearchSizingFactoryProtocol {
    func sizeForLoadingCell(with collectionView: UICollectionView) -> CGSize
    func sizeForUserCell(with collectionView: UICollectionView) -> CGSize
    func sectionInsets(for section: OKMatchSearchSection) -> UIEdgeInsets
    func itemSpacing(for section: OKMatchSearchSection) -> CGFloat
}
