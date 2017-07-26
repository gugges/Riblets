//
//  AppDelegate.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

protocol OKAppDelegate: class {
    func didFinishLaunching(with launchOptions: [UIApplicationLaunchOptionsKey: Any]?)
    func application(continue userActivity: NSUserActivity) -> Bool
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var rootRouter: OKRootRouter?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        
        rootRouter = OKRootBuilder.build()
        rootRouter?.delegate = self
        rootRouter?.didFinishLaunching(with: launchOptions)
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        return rootRouter?.application(continue: userActivity) ?? false
    }
    
}

extension AppDelegate: OKRouterDelegate {
    
    func present(viewController: UIViewController, animated: Bool) {
        guard let currentViewController = window?.rootViewController, animated else {
            window?.rootViewController = viewController
            return
        }
        
        UIView.transition(from: currentViewController.view, to: viewController.view, duration: 0.45, options: .transitionFlipFromLeft) { (done) in
            self.window?.rootViewController = viewController
        }
    }
    
}
