//
//  OKViewController.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

@objc protocol OKViewControllerDelegate: class {
    @objc optional func viewDidLoad()
    @objc optional func viewWillAppear()
    @objc optional func viewDidAppear()
    @objc optional func viewWillDisappear()
    @objc optional func viewDidDisappear()
    @objc optional func prefersStatusBarHidden() -> Bool
    @objc optional func preferredStatusBarStyle() -> UIStatusBarStyle
    @objc optional func navigationButtonTapped(at index: Int)
    @objc optional func refresh()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerDelegate?.viewDidLoad?()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        controllerDelegate?.viewWillAppear?()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        controllerDelegate?.viewDidAppear?()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        controllerDelegate?.viewWillDisappear?()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        controllerDelegate?.viewDidDisappear?()
    }
}
