//
//  OKSearchPresenter.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

final class OKSearchPresenter: OKPresenter {
    
    var viewRouters = [OKRouter]()
    
    override init(viewController: UIViewController) {
        super.init(viewController: viewController)
        
        if let viewController = viewController as? OKSearchViewController {
            viewController.delegate = self
        }
    }
    
    //MARK: - From Interactor
    
    func add(routers: OKRouter) {
    
    }
}

extension OKSearchPresenter: OKSearchViewDelegate {
    
    func navigationButtonTapped(at index: Int) {
        
    }
    
    func tappedItem(at indexPath: IndexPath) {
        
    }
    
}
