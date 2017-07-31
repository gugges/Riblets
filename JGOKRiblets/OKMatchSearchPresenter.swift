//
//  OKSearchPresenter.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

protocol OKMatchSearchPresenterProtocol {
    func add(matches: [OKUser])
    func display(error: Error?)
}

final class OKMatchSearchPresenter: OKPresenter, OKMatchSearchPresenterProtocol {
    
    override init(viewController: UIViewController) {
        super.init(viewController: viewController)
        
        matchSearchViewController()?.controllerDelegate = self
        setupCollectionView()
    }
    
    //MARK: - OKMatchSearchPresenterProtocol
    
    func add(matches: [OKUser]) {
        // Convert to view models on background thread
    }
    
    func display(error: Error?) {
        // Format error
    }
    
    //MARK: - Setup
    
    fileprivate func setupCollectionView() {
        let userCell = String(describing: OKMatchSearchUserCell.self)
        matchSearchViewController()?.collectionView.register(UINib(nibName: userCell, bundle: nil), forCellWithReuseIdentifier: userCell)
        matchSearchViewController()?.collectionView.dataSource = self
        matchSearchViewController()?.collectionView.delegate = self
    }
    
    //MARK: - Helpers
    
    fileprivate func matchSearchInteractor() -> OKMatchSearchInteractor? {
        return interactor as? OKMatchSearchInteractor
    }
    
    fileprivate func matchSearchViewController() -> OKMatchSearchViewController? {
        return viewController as? OKMatchSearchViewController
    }
    
}

//MARK: - OKViewControllerDelegate

extension OKMatchSearchPresenter: OKViewControllerDelegate {
    
    func viewDidLoad() {
        matchSearchInteractor()?.reloadMatches()
    }
    
    func navigationButtonTapped(at index: Int) {
        
    }
    
    func tappedItem(at indexPath: IndexPath) {
        
    }
    
}

//MARK: - UICollectionViewDelegate

extension OKMatchSearchPresenter: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      
        if scrollView.pagesRemaining() < 1.5 {
            matchSearchInteractor()?.nextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: - UICollectionViewDataSource

extension OKMatchSearchPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
    
}
