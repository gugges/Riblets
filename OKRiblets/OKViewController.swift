//
//  OKViewController.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

@objc protocol OKViewControllerDelegate: class {
    @objc optional func prefersStatusBarHidden() -> Bool
    @objc optional func preferredStatusBarStyle() -> UIStatusBarStyle
    
    @objc optional func viewDidLoad()
    @objc optional func viewWillAppear()
    @objc optional func viewDidAppear()
    @objc optional func viewWillDisappear()
    @objc optional func viewDidDisappear()
    
    @objc optional func reload()
    @objc optional func nextPage()
    @objc optional func previousPage()
}

class OKViewController: UIViewController {

    weak var presenter: OKPresenter?
    weak var controllerDelegate: OKViewControllerDelegate?
    
    override var prefersStatusBarHidden: Bool {
        return controllerDelegate?.prefersStatusBarHidden?() ?? false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return controllerDelegate?.preferredStatusBarStyle?() ?? .lightContent
    }
    
    func animateErrorState(visible: Bool) {
        fatalError("animateErrorState not implemented")
    }
}
