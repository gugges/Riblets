//
//  OKSearchViewController.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

protocol OKMatchSearchViewControllerProtocol {
    func showErrorState()
}

final class OKMatchSearchViewController: OKViewController, OKMatchSearchViewControllerProtocol {
    
    let collectionView: UICollectionView = {
        var collectionViewLayout = UICollectionViewFlowLayout()
        return UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    }()
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupRefreshControl()
    }
    
    //MARK: - Layout
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context) in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
    
    //MARK: - Actions
    
    func refresh() {
        // Simulate async call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.refreshControl.endRefreshing()
            self.controllerDelegate?.refresh?()
        }
    }
    
    //MARK: - OKMatchSearchViewControllerProtocol
    
    func showErrorState() {
        
    }
    
    //MARK: - Setup
    
    fileprivate func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.pinToEdges(superView: view)
    }
    
    fileprivate func setupRefreshControl() {
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

}
