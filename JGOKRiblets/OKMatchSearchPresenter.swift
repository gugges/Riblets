//
//  OKSearchPresenter.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

protocol OKMatchSearchPresenterProtocol {
    func add(users: [OKUser])
    func display(error: Error?)
}

final class OKMatchSearchPresenter: OKPresenter, OKMatchSearchPresenterProtocol {
    
    fileprivate var matches = [OKMatchSearchUser]()
    
    override init(viewController: UIViewController) {
        super.init(viewController: viewController)
        
        matchSearchViewController()?.controllerDelegate = self
    }
    
    //MARK: - OKMatchSearchPresenterProtocol
    
    func add(users: [OKUser]) {
        var indexPaths = [IndexPath]()
        
        for user in users {
            indexPaths.append(IndexPath(item: matches.count, section: 0))
            matches.append(OKMatchSearchUser(user: user))
        }
        
        let collectionView = matchSearchViewController()?.collectionView
        
        UIView.performWithoutAnimation {
            collectionView?.performBatchUpdates({
                collectionView?.insertItems(at: indexPaths)
            }, completion: nil)
        }
    }
    
    func display(error: Error?) {
        // Format error
    }
    
    //MARK: - Setup
    
    fileprivate func setupViewController() {
        matchSearchViewController()?.view.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 245/255, alpha: 1)
        matchSearchViewController()?.navigationController?.navigationBar.clipsToBounds = false
        matchSearchViewController()?.navigationController?.navigationBar.isTranslucent = false
        matchSearchViewController()?.navigationController?.navigationBar.barTintColor = UIColor(red: 93/255, green: 143/255, blue: 222/255, alpha: 1)
        matchSearchViewController()?.navigationController?.navigationBar.tintColor = .white
    }
    
    fileprivate func setupCollectionView() {
        let userCell = String(describing: OKMatchSearchUserCell.self)
        matchSearchViewController()?.collectionView.register(UINib(nibName: userCell, bundle: nil), forCellWithReuseIdentifier: userCell)
        matchSearchViewController()?.collectionView.dataSource = self
        matchSearchViewController()?.collectionView.delegate = self
        matchSearchViewController()?.collectionView.backgroundColor = .clear
        
        let itemSpacing: CGFloat = 16
        
        if let flowLayout = matchSearchViewController()?.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.sectionInset = UIEdgeInsets(top: itemSpacing, left: itemSpacing, bottom: itemSpacing, right: itemSpacing)
            flowLayout.minimumInteritemSpacing = itemSpacing
            flowLayout.minimumLineSpacing = itemSpacing
        }
    }
    
    //MARK: - Helpers
    
    fileprivate func matchSearchInteractor() -> OKMatchSearchInteractor? {
        return interactor as? OKMatchSearchInteractor
    }
    
    fileprivate func matchSearchViewController() -> OKMatchSearchViewController? {
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.first as? OKMatchSearchViewController
        }
        
        return viewController as? OKMatchSearchViewController
    }
    
}

//MARK: - OKViewControllerDelegate

extension OKMatchSearchPresenter: OKViewControllerDelegate {
    
    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }
    
    func viewDidLoad() {
        setupViewController()
        setupCollectionView()
        
        matchSearchInteractor()?.reloadMatches()
    }
    
    func refresh() {
        matches.removeAll()
        matchSearchViewController()?.collectionView.reloadData()
        matchSearchInteractor()?.reloadMatches()
    }
    
}

//MARK: - UICollectionViewDelegate

extension OKMatchSearchPresenter: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      
        if scrollView.pagesRemaining() < 1.5 {
            matchSearchInteractor()?.nextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        matchSearchInteractor()?.selected(user: matches[indexPath.item].user)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let collectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("CollectionView requires flow layout")
        }
        
        let itemsPerRow: CGFloat = 2
        let marginsAndInsets: CGFloat = collectionViewFlowLayout.sectionInset.left + collectionViewFlowLayout.sectionInset.right + collectionViewFlowLayout.minimumInteritemSpacing * (itemsPerRow - 1)
        let width: CGFloat = (collectionView.frame.width - marginsAndInsets) / itemsPerRow
        let height: CGFloat = 280
        return CGSize(width: width, height: height)
    }
}

//MARK: - UICollectionViewDataSource

extension OKMatchSearchPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: OKMatchSearchUserCell = collectionView.dequeueReusableCell(for: indexPath)
        let user = matches[indexPath.item]
        cell.configure(with: user)
        
        return cell
    }
    
}
