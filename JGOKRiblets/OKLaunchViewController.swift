//
//  OKLaunchViewController.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 8/6/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

class OKLaunchViewController: OKViewController {
    
    convenience init() {
        self.init(nibName: "OKLaunchViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .colorBlue3()
    }

}
