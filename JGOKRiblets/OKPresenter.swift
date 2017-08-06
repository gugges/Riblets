//
//  OKPresenter.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/23/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

class OKPresenter: NSObject {
    
    let viewController: UIViewController
    weak var interactor: OKInteractor?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func display(alertControllerContext: OKAlertControllerContext) {
        let alertController = UIAlertController(title: alertControllerContext.title, message: alertControllerContext.subtitle, preferredStyle: alertControllerContext.preferredStyle)
        
        for actionContext in alertControllerContext.actions {
            let alertAction = UIAlertAction(title: actionContext.title, style: actionContext.style, handler: actionContext.handler)
            
            alertController.addAction(alertAction)
        }
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
