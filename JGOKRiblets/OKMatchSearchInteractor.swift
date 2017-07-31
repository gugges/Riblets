//
//  OKMatchSearchInteractor.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

protocol OKMatchSearchInteractorProtocol: class {
    func reloadMatches()
    func nextPage()
    func selected(user: OKUser)
}

final class OKMatchSearchInteractor: OKInteractor, OKMatchSearchInteractorProtocol {

    fileprivate let matchSearchNetworkManager = OKMatchSearchNetworkManager()
    
    //MARK: - OKMatchSearchInteractorProtocol
    
    func reloadMatches() {
        matchSearchNetworkManager.getMatches { (result) in
            switch result {
            case .success(let matches):
                self.matchSearchPresenter()?.add(matches: matches)
                
            case .failure(let error):
                self.matchSearchPresenter()?.display(error: error)
            }
        }
    }
    
    func nextPage() {
        
    }
    
    func selected(user: OKUser) {
        //router?.present(router: <#T##OKRouter#>, animated: <#T##Bool#>)
    }
    
    //MARK: - Helpers
    
    fileprivate func matchSearchPresenter() -> OKMatchSearchPresenter? {
        return presenter as? OKMatchSearchPresenter
    }
}
