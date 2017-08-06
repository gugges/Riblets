//
//  OKMatchSearchUserCell.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/30/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

final class OKMatchSearchUserCell: UICollectionViewCell {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var ageLocationLabel: UILabel!
    @IBOutlet weak var matchPercentLabel: UILabel!
    @IBOutlet weak var labelBackgroundView: UIView!
    
    @IBOutlet weak var usernameTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var usernameBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var ageLocationBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var matchPercentToBottomConstraint: NSLayoutConstraint!
    
    fileprivate var imageDataTask: URLSessionDataTask?

    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageDataTask?.cancel()
        profilePictureImageView.image = nil
    }
    
    deinit {
        imageDataTask?.cancel()
    }
    
}

extension OKMatchSearchUserCell {   
    
    func configure(with matchUser: OKMatchSearchUser) {
        matchUser.roundCorners(cell: self)
        matchUser.addShadow(cell: self)
        
        usernameTopConstraint.constant = matchUser.constraints.usernameTopSpacing
        usernameBottomConstraint.constant = matchUser.constraints.usernameBottomSpacing
        ageLocationBottomConstraint.constant = matchUser.constraints.ageLocationBottomSpacing
        matchPercentToBottomConstraint.constant = matchUser.constraints.matchPercentBottomSpacing
        
        labelBackgroundView.backgroundColor = matchUser.labelBackgroundColor()
        profilePictureImageView.backgroundColor = matchUser.imageViewBackgroundColor()
        
        profilePictureImageView.contentMode = matchUser.profilePhotoContentMode()
        
        usernameLabel.attributedText = matchUser.username()
        ageLocationLabel.attributedText = matchUser.ageLocation()
        matchPercentLabel.attributedText = matchUser.matchPercent()
        
        imageDataTask = matchUser.imageNetworkManager.request(url: matchUser.profilePhotoImageURL()) { [weak self] (image) in
            self?.profilePictureImageView.image = image
        }
    }
}
