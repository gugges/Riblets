//
//  OKSearchViewController.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

final class OKMatchSearchViewController: OKViewController {
    
    let collectionView: UICollectionView = {
        var collectionViewLayout = UICollectionViewFlowLayout()
        return UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
    }()
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCollectionView()
        addRefreshControl()
        controllerDelegate?.viewDidLoad?()
    }
    
    //MARK: - Layout
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context) in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
    
    //MARK: - Actions
    
    override func animateErrorState(visible: Bool) {
        
    }
    
    @objc fileprivate func refresh() {
        self.controllerDelegate?.refresh?()
    }
    
    //MARK: - Setup
    
    fileprivate func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.pinToEdges(superview: view)
    }
    
    fileprivate func addRefreshControl() {
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

}
