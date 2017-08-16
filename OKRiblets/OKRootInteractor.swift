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
            self.present(state: .loggedIn)
        }
    }
    
    //MARK: - States
    
    fileprivate func present(state: OKRootState) {
        if state == currentContext?.state {
            print("Trying to present the current state. You ok?")
            return
        }
        
        dismissCurrentContext()
        
        let childRouter: OKRouter
        let animated: Bool
        
        switch state {
        case .launch:
            childRouter = OKLaunchBuilder.build(components: nil)
            animated = false
            
        case .loginLink:
            childRouter = OKLaunchBuilder.build(components: nil)
            animated = false
            
        case .loggedOut:
            childRouter = OKLaunchBuilder.build(components: nil)
            animated = true
            
        case .loggedIn:
            // Pass along deep link to log in builder
            childRouter = OKMatchSearchBuilder.build(components: nil)
            animated = true
        }
        
        currentContext = (state: state, router: childRouter)
        
        router?.push(childRouter: childRouter, animated: animated)
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
        
        // Setup frameworks
        // Parse launch options to capture deep link
        // Show appropriate loading state
        present(state: .launch)
        
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
