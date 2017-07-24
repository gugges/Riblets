//
//  OKSearchViewController.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

protocol OKSearchViewDelegate: class {
    func navigationButtonTapped(at index: Int)
    func tappedItem(at indexPath: IndexPath)
}

final class OKSearchViewController: OKViewController {
    
    weak var delegate: OKSearchViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

}
