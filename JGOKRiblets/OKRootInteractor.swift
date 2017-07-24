//
//  OKRootInteractor.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

enum OKRootState {
    case launch, loginLink, loggedOut, loggedIn
}

final class OKRootInteractor: OKInteractor {
    
    var launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    var currentContext: (state: OKRootState, type: OKRouter.Type)?
    
    //MARK: - Bootstrap
    
    fileprivate func fetchBootstrap() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.present(state: .loggedIn)
        }
    }
    
    //MARK: - States
    
    fileprivate func present(state: OKRootState) {
        if state == currentContext?.state {
            return
        }
        
        dismissCurrentContext()
        
        let router: OKRouter
        
        switch state {
        case .launch:
            router = OKLaunchBuilder.build()
            
        case .loginLink:
            router = OKLaunchBuilder.build()
            
        case .loggedOut:
            router = OKLaunchBuilder.build()
            
        case .loggedIn:
            router = OKSearchBuilder.build()
        }
        
        currentContext = (state: state, type: type(of: router))
        
        delegate?.present(router: router)
    }
    
    fileprivate func dismissCurrentContext() {
        guard let currentContext = currentContext else {
            return
        }
        
        delegate?.dismiss(routerType: currentContext.type)
    }
    
}

//MARK: - OKAppDelegate

extension OKRootInteractor: OKAppDelegate {
    
    func didFinishLaunching(with launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        self.launchOptions = launchOptions
        present(state: .launch)
        fetchBootstrap()
    }
    
    func application(continue userActivity: NSUserActivity) -> Bool {
        return true
    }
}
