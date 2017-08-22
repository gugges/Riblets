//
//  OKRootInteractor.swift
//  OKRiblets
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
    var currentContext: (state: OKRootState, router: OKRouter)?
    
    //MARK: - Bootstrap
    
    fileprivate func fetchBootstrap() {
        // Simulate async login after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.update(state: .loggedIn)
        }
    }
    
    //MARK: - States
    
    fileprivate func update(state: OKRootState) {
        if state == currentContext?.state {
            fatalError("Trying to update to the current root state")
        }
        
        dismissCurrentContext()
        
        let navigationContext: OKNavigationContext?
        let animated: Bool
        
        switch state {
        case .launch:
            navigationContext = OKNavigationContext(router: OKLaunchBuilder.build(components: 0), isNavigationController: false)
            animated = false
            
        case .loginLink:
            navigationContext = OKNavigationContext(router: OKLaunchBuilder.build(components: 0), isNavigationController: false)
            animated = false
            
        case .loggedOut:
            navigationContext = OKNavigationContext(router: OKLaunchBuilder.build(components: 0), isNavigationController: false)
            animated = true
            
        case .loggedIn:
            //TODO: Pass along deep link to log in builder
            let matchSearchComponents = OKMatchSearchComponents(networkManager: OKMatchSearchNetworkManager())
            navigationContext = OKNavigationContext(router: OKMatchSearchBuilder.build(components: matchSearchComponents), isNavigationController: true)
            animated = true
        }

        if let navigationContext = navigationContext {
            currentContext = (state: state, router: navigationContext.router)
            router?.setRoot(navigationContext: navigationContext, animated: animated)
        } else {
            fatalError("Cannot present nil navigationContext")
        }
    }
    
    fileprivate func dismissCurrentContext() {
        guard let currentContext = currentContext else {
            return
        }
        
        router?.dismiss(childRouter: currentContext.router)
        self.currentContext = nil
    }

}

//MARK: - OKAppDelegate

extension OKRootInteractor: OKAppDelegateHandler {
    
    func didFinishLaunching(with launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        self.launchOptions = launchOptions
        _ = launchOptions?[UIApplicationLaunchOptionsKey.url] as? String
        
        //TODO: Setup frameworks
        //TODO: Parse launch options to capture deep link
        //TODO: Show appropriate loading state
        update(state: .launch)
        
        // Fetch bootstrap
        fetchBootstrap()
    }
    
    func application(continue userActivity: NSUserActivity) -> Bool {
        return true
    }
    
    func application(open url: URL) -> Bool {
        return true
    }
    
}
