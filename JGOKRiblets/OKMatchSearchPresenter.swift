//
//  OKSearchPresenter.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

final class OKMatchSearchPresenter: OKPresenter {
    
    var viewRouters = [OKRouter]()
    
    override init(viewController: UIViewController) {
        super.init(viewController: viewController)
        matchSearchViewController()?.delegate = self
    }
    
    func add(matches: [OKUser]) {
        
    }
    
    func display(error: Error?) {
        
    }
    
    //MARK: - Helpers
    
    fileprivate func matchSearchInteractor() -> OKMatchSearchInteractor? {
        return interactor as? OKMatchSearchInteractor
    }
    
    fileprivate func matchSearchViewController() -> OKMatchSearchViewController? {
        return viewController as? OKMatchSearchViewController
    }
    
}

extension OKMatchSearchPresenter: OKMatchSearchViewDelegate {
    
    func viewDidLoad() {
        matchSearchInteractor()?.fetchMatches()
    }
    
    func navigationButtonTapped(at index: Int) {
        
    }
    
    func tappedItem(at indexPath: IndexPath) {
        
    }
    
}
