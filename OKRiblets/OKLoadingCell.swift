//
//  OKLoadingCell.swift
//  OKRiblets
//
//  Created by Jordan Guggenheim on 8/5/17.
//  Copyright © 2017 OkCupid. All rights reserved.
//

import UIKit

class OKLoadingCell: UICollectionViewCell {

    @IBOutlet fileprivate weak var imageView: UIImageView!

    fileprivate let images = [#imageLiteral(resourceName: "avocado"),#imageLiteral(resourceName: "cat_1"),#imageLiteral(resourceName: "burger"),#imageLiteral(resourceName: "boot"),#imageLiteral(resourceName: "ugg"),#imageLiteral(resourceName: "backpack")]
    fileprivate var rotationAnimation: CABasicAnimation?
    
    //MARK: - Asset
    
    func advanceImage() {
        if let currentImage = imageView.image {
            if let currentIndex = images.index(of: currentImage) {
                let nextIndex = images.index(after: currentIndex)
                let isAtEnd = nextIndex == images.endIndex
                imageView.image = isAtEnd ? images.first : images[nextIndex]
            }
            
        } else {
            imageView.image = images.first
        }
    }
    
    //MARK: - Animations
    
    func animateRotation(active: Bool) {
        active ? startAnimating() : stopAnimating()
    }
    
    fileprivate func startAnimating() {
        rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        
        guard let rotationAnimation = rotationAnimation else {
            return
        }
        
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = .pi * 2.0
        rotationAnimation.duration = 1.35
        rotationAnimation.repeatCount = .infinity
        rotationAnimation.isRemovedOnCompletion = false
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    fileprivate func stopAnimating() {
        layer.removeAllAnimations()
        rotationAnimation = nil
    }

}
