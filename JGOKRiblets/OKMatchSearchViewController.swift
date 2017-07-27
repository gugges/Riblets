//
//  OKSearchViewController.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

protocol OKMatchSearchViewDelegate: OKViewControllerDelegate {
    func navigationButtonTapped(at index: Int)
    func tappedItem(at indexPath: IndexPath)
}

final class OKMatchSearchViewController: OKViewController {
    
    weak var delegate: OKMatchSearchViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        delegate?.viewDidLoad?()
    }

}
