//
//  OKSearchPresenter.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

final class OKMatchSearchPresenter: OKPresenter, OKMatchSearchPresenterProtocol {
    
    fileprivate var matches = [OKMatchSearchSection : [OKMatchSearchObject]]()
    fileprivate var Interactor: OKMatchSearchInteractor? { return interactor as? OKMatchSearchInteractor }
    fileprivate var ViewController: OKMatchSearchViewController? { return viewController.ok_viewController() as? OKMatchSearchViewController }
    fileprivate let sizingFactory: OKMatchSearchSizingFactoryProtocol
    
    init(viewController: UIViewController, sizingFactory: OKMatchSearchSizingFactoryProtocol = OKMatchSearchSizingFactory()) {
        self.sizingFactory = sizingFactory
        super.init(viewController: viewController)
        ViewController?.controllerDelegate = self
    }
    
    //MARK: - OKMatchSearchPresenterProtocol
    
    func add(users: [OKUser]) {
        var indexPaths = [IndexPath]()
        var currentUsers = matches[.user] ?? [OKMatchSearchObject]()
        var currentLoading = matches[.loading] ?? [OKMatchSearchObject]()
        
        for user in users {
            indexPaths.append(IndexPath(item: currentUsers.count, section: OKMatchSearchSection.user.rawValue))
            currentUsers.append(.user(OKMatchSearchUser(user: user)))
        }
        
        if currentLoading.isEmpty {
            indexPaths.append(IndexPath(item: currentLoading.count, section: OKMatchSearchSection.loading.rawValue))
            currentLoading.append(.loading)
        }
        
        matches[.loading] = currentLoading
        matches[.user] = currentUsers
        
        self.ViewController?.refreshControl.endRefreshing()
        self.ViewController?.collectionView.performBatchUpdates({ [weak self] in
            self?.ViewController?.collectionView.insertItems(at: indexPaths)
        }, completion: nil)
    }
    
    func display(error: Error?) {
        // Format error
    }
    
    //MARK: - Helpers
    
    fileprivate func object(at indexPath: IndexPath) -> OKMatchSearchObject? {
        let section = OKMatchSearchSection(rawValue: indexPath.section)
        
        guard let objects = matches[section], indexPath.item < objects.count else {
            return nil
        }
        
        return matches[section]?[indexPath.item]
    }
    
    fileprivate func refreshMatches() {
        matches.removeAll()
        ViewController?.collectionView.reloadData()
        Interactor?.reloadMatches()
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
        ViewController?.collectionView.register(OKLoadingCell.nib, forCellWithReuseIdentifier: OKLoadingCell.reuseID)
        ViewController?.collectionView.register(OKMatchSearchUserCell.nib, forCellWithReuseIdentifier: OKMatchSearchUserCell.reuseID)
        ViewController?.collectionView.dataSource = self
        ViewController?.collectionView.delegate = self
        ViewController?.collectionView.backgroundColor = .clear
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
        refreshMatches()
    }
    
}

//MARK: - UICollectionViewDataSource

extension OKMatchSearchPresenter: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return OKMatchSearchSection.loading.rawValue + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matches[OKMatchSearchSection(rawValue: section)]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let object = object(at: indexPath) else {
            fatalError("IndexPath \(indexPath) out of bounds")
        }
        
        switch object {
        case .loading:
            let cell: OKLoadingCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
            
        case .user(let matchUser):
            let cell: OKMatchSearchUserCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.configure(with: matchUser)
            return cell
        }
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension OKMatchSearchPresenter: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      
        if scrollView.pagesRemaining() == 0 {
            Interactor?.nextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let object = object(at: indexPath) else {
            return
        }
        
        switch object {
        case .loading:
            break
            
        case .user(let matchUser):
            Interactor?.selected(user: matchUser.user)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sizingFactory.sectionInsets(for: OKMatchSearchSection(rawValue: section))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sizingFactory.itemSpacing(for: OKMatchSearchSection(rawValue: section))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sizingFactory.itemSpacing(for: OKMatchSearchSection(rawValue: section))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let object = object(at: indexPath) else {
            return .zero
        }
        
        switch object {
        case .loading:
            return sizingFactory.sizeForLoadingCell(with: collectionView)
            
        case .user(_):
            return sizingFactory.sizeForUserCell(with: collectionView)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let object = object(at: indexPath) else {
            return
        }
        
        switch object {
        case .loading:
            (cell as? OKLoadingCell)?.advanceImage()
            (cell as? OKLoadingCell)?.animateRotation(active: true)
            
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let object = object(at: indexPath) else {
            return
        }
        
        switch object {
        case .loading:
            (cell as? OKLoadingCell)?.animateRotation(active: false)
            
        default:
            break
        }
    }
}
