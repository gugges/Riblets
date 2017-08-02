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
    fileprivate var fetchInProgress = false
    fileprivate var Presenter: OKMatchSearchPresenter? { return presenter as? OKMatchSearchPresenter }
    
    //MARK: - OKMatchSearchInteractorProtocol
    
    func reloadMatches() {
        if fetchInProgress {
            return
        }
        
        fetchInProgress = true
        
        matchSearchNetworkManager.getMatches { (result) in
            switch result {
            case .success(let users):
                self.Presenter?.add(users: users)
                
            case .failure(let error):
                self.Presenter?.display(error: error)
            }
            
            self.fetchInProgress = false
        }
    }
    
    func nextPage() {
        reloadMatches()
    }
    
    func selected(user: OKUser) {
        // Fire mParticle Stats Here
        // Create profile child router
        // Ask router to push child router
        
        let matchSearchRouter = OKMatchSearchBuilder.build(components: false)
        router?.push(childRouter: matchSearchRouter, animated: true)
    }

}
