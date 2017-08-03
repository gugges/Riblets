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
    fileprivate var Interactor: OKMatchSearchInteractor? { return interactor as? OKMatchSearchInteractor }
    
    fileprivate var ViewController: OKMatchSearchViewController? {
        if let navigationController = viewController as? UINavigationController {
            return navigationController.viewControllers.first as? OKMatchSearchViewController
        }
        
        return viewController as? OKMatchSearchViewController
    }
    
    override init(viewController: UIViewController) {
        super.init(viewController: viewController)
        
        ViewController?.controllerDelegate = self
    }
    
    //MARK: - OKMatchSearchPresenterProtocol
    
    func add(users: [OKUser]) {
        var indexPaths = [IndexPath]()
        
        for user in users {
            indexPaths.append(IndexPath(item: matches.count, section: 0))
            matches.append(OKMatchSearchUser(user: user))
        }
        
        let collectionView = ViewController?.collectionView
        
        collectionView?.performBatchUpdates({
            collectionView?.insertItems(at: indexPaths)
        }, completion: nil)
    }
    
    func display(error: Error?) {
        // Format error
    }
    
    func display(alertViewContext: Any) {
        
    }
    
    //MARK: - Setup
    
    fileprivate func setupViewController() {
        ViewController?.view.backgroundColor = .colorGray7()
        ViewController?.navigationController?.navigationBar.clipsToBounds = false
        ViewController?.navigationController?.navigationBar.isTranslucent = false
        ViewController?.navigationController?.navigationBar.barTintColor = .colorBlue3()
        ViewController?.navigationController?.navigationBar.tintColor = .white
    }
    
    fileprivate func setupCollectionView() {
        ViewController?.collectionView.register(UINib(nibName: OKMatchSearchUserCell.reuseID(), bundle: nil), forCellWithReuseIdentifier: OKMatchSearchUserCell.reuseID())
        ViewController?.collectionView.dataSource = self
        ViewController?.collectionView.delegate = self
        ViewController?.collectionView.backgroundColor = .clear
        
        let itemSpacing: CGFloat = 16
        
        if let flowLayout = ViewController?.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.sectionInset = UIEdgeInsets(top: itemSpacing, left: itemSpacing, bottom: itemSpacing, right: itemSpacing)
            flowLayout.minimumInteritemSpacing = itemSpacing
            flowLayout.minimumLineSpacing = itemSpacing
        }
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
        
        Interactor?.reloadMatches()
    }
    
    func refresh() {
        matches.removeAll()
        ViewController?.collectionView.reloadData()
        Interactor?.reloadMatches()
    }
    
}

//MARK: - UICollectionViewDelegate

extension OKMatchSearchPresenter: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      
        if scrollView.pagesRemaining() < 1.5 {
            Interactor?.nextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Interactor?.selected(user: matches[indexPath.item].user)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let collectionViewFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("CollectionView requires flow layout")
        }
        
        let itemsPerRow: CGFloat = 2
        let itemsPerColumn: CGFloat = 2
        
        let hMarginsAndInsets: CGFloat = collectionViewFlowLayout.sectionInset.left + collectionViewFlowLayout.sectionInset.right + collectionViewFlowLayout.minimumInteritemSpacing * (itemsPerRow - 1)
        let vMarginsAndInsets: CGFloat = collectionViewFlowLayout.sectionInset.top + collectionViewFlowLayout.sectionInset.bottom + collectionViewFlowLayout.minimumLineSpacing * (itemsPerRow - 1)
        
        let width: CGFloat = floor((collectionView.frame.width - hMarginsAndInsets) / itemsPerRow)
        let height: CGFloat = floor((collectionView.frame.height - vMarginsAndInsets) / itemsPerColumn)
        
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
