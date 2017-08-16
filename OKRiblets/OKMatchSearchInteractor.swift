//
//  OKMatchSearchInteractor.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

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
        
        matchSearchNetworkManager.getMatches { [weak self] (result) in
            switch result {
            case .success(let users):
                self?.Presenter?.add(users: users)
                
            case .failure(let error):
                self?.Presenter?.display(error: error)
            }
            
            self?.fetchInProgress = false
        }
    }
    
    func nextPage() {
        reloadMatches()
    }
    
    func selected(user: OKUser) {
        // Fire mParticle Stats Here
        // Create profile child router
        // Ask router to push child router

        // Contrived scenarios to test alert controllers && actions
        if user.username == "bklyn2356" {
            Presenter?.display(alertControllerContext: reloadDataAlertControllerContext())
            
        } else if user.username == "strwbrryasaurus" {
            Presenter?.display(alertControllerContext: popToRootAlertControllerContext())
            
        } else {
            let matchSearchRouter = OKMatchSearchBuilder.build(components: false)
            router?.push(childRouter: matchSearchRouter, animated: true)
        }
        
    }
    
    //MARK: - Alert Controller Contexts
    
    fileprivate func reloadDataAlertControllerContext() -> OKAlertControllerContext {
        let refreshActionContext = OKAlertActionContext(title: "Reload!", style: .cancel) { [weak self] _ in
            self?.Presenter?.reload()
        }
        let cancelActionContext = OKAlertActionContext(title: "Cancel", style: .default, handler: nil)
        return OKAlertControllerContext(title: "Reload all matches?", subtitle: "So fresh and so clean.", preferredStyle: .alert, actions: [refreshActionContext, cancelActionContext])
    }
    
    fileprivate func popToRootAlertControllerContext() -> OKAlertControllerContext {
        let popActionContext = OKAlertActionContext(title: "Pop, lock, and drop it.", style: .default) { [weak self] _ in
            self?.Presenter?.viewController.navigationController?.popToRootViewController(animated: true)
        }
        let cancelActionContext = OKAlertActionContext(title: "Cancel", style: .default, handler: nil)
        return OKAlertControllerContext(title: "Pop to root view controller?", subtitle: "It's poppin.", preferredStyle: .actionSheet, actions: [popActionContext, cancelActionContext])
    }

}
