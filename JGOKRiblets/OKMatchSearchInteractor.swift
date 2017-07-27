//
//  OKMatchSearchInteractor.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

final class OKMatchSearchInteractor: OKInteractor {

    private let matchSearchNetworkManager = OKMatchSearchNetworkManager()
    
    func fetchMatches() {
        matchSearchNetworkManager.getMatches { (result) in
            switch result {
            case .success(let matches):
                self.matchSearchPresenter()?.add(matches: matches)
                
            case .failure(let error):
                self.matchSearchPresenter()?.display(error: error)
            }
        }
    }
    
    //MARK: - Helpers
    
    private func matchSearchPresenter() -> OKMatchSearchPresenter? {
        return presenter as? OKMatchSearchPresenter
    }
}
