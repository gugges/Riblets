//
//  OKMatchSearchUserCell.swift
//  JGOKRiblets
//
//  Created by Jordan Guggenheim on 7/30/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

class OKMatchSearchUserCell: UICollectionViewCell {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var ageLocationLabel: UILabel!
    @IBOutlet weak var matchPercentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        profilePictureImageView.image = nil
    }
    
}
