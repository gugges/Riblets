//
//  OKMatchSearchUser.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/31/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

struct OKMatchSearchUserConstraintSizes {
    let usernameTopSpacing: CGFloat
    let usernameBottomSpacing: CGFloat
    let ageLocationBottomSpacing: CGFloat
    let matchPercentBottomSpacing: CGFloat
}

struct OKMatchSearchUser {
    
    let user: OKUser
    let imageNetworkManager: OKImageNetworkManagerProtocol
    let constraints = OKMatchSearchUserConstraintSizes(usernameTopSpacing: 16,
                                                       usernameBottomSpacing: 6,
                                                       ageLocationBottomSpacing: 12,
                                                       matchPercentBottomSpacing: 16)
    
    init(user: OKUser, imageNetworkManager: OKImageNetworkManagerProtocol = OKImageNetworkManager()) {
        self.user = user
        self.imageNetworkManager = imageNetworkManager
    }
    
    func ageLocation() -> NSAttributedString {
        let ageLocation = "\(user.age) ∙ \(user.location.cityName), \(user.location.stateCode)"
        let attributes = [NSForegroundColorAttributeName : UIColor.lightGray,
                          NSFontAttributeName : UIFont.systemFont(ofSize: 14)]
        return NSAttributedString(string: ageLocation, attributes: attributes)
    }
    
    func matchPercent() -> NSAttributedString {
        let ageLocation = "\(user.match / 100)% Match"
        let attributes = [NSForegroundColorAttributeName : UIColor.darkGray,
                          NSFontAttributeName : UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)]
        return NSAttributedString(string: ageLocation, attributes: attributes)
    }
    
    func username() -> NSAttributedString {
        let ageLocation = user.username
        let attributes = [NSForegroundColorAttributeName : UIColor.darkGray,
                          NSFontAttributeName : UIFont.boldSystemFont(ofSize: 16)]
        
        return NSAttributedString(string: ageLocation, attributes: attributes)
    }
    
    func showOnlineIndicator() -> Bool {
        return user.isOnline
    }
    
    func profilePhotoImageURL() -> URL {
        return user.photo.largeUrl
    }
    
    func profilePhotoContentMode() -> UIViewContentMode {
        return .scaleAspectFill
    }
    
    func labelBackgroundColor() -> UIColor {
        return .white
    }
    
    func imageViewBackgroundColor() -> UIColor {
        return UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
    }
    
    func roundCorners(cell: UICollectionViewCell) {
        cell.contentView.layer.cornerRadius = 3.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
    }
    
    func addShadow(cell: UICollectionViewCell) {
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.layer.shadowRadius = 1.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
    }
}
