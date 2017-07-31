//
//  OKSearchViewController.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

protocol OKMatchSearchViewControllerProtocol {    
    func reloadData()
    func showErrorState()
    func addPage(with: [OKUser])
}

final class OKMatchSearchViewController: OKViewController, OKMatchSearchViewControllerProtocol {
    
    let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        return UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    //MARK: - Layout
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context) in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
    
    //MARK: - OKMatchSearchViewControllerProtocol
    
    func reloadData() {
        
    }
    
    func showErrorState() {
        
    }
    
    func addPage(with: [OKUser]) {
        
    }

}
