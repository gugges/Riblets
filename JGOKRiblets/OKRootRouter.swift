//
//  OKRootRouter.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

final class OKRootRouter: OKRouter {
    
    //MARK: - Helpers
    
    fileprivate func rootInteractor() -> OKRootInteractor? {
        return interactor as? OKRootInteractor
    }
    
}

//MARK: - OKAppDelegate

extension OKRootRouter: OKAppDelegate {
    
    func didFinishLaunching(with launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        rootInteractor()?.didFinishLaunching(with: launchOptions)
    }
    
    func application(continue userActivity: NSUserActivity) -> Bool {
        return rootInteractor()?.application(continue: userActivity) ?? false
    }
    
}
