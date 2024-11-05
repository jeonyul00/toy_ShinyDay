//
//  DetailInfoCollectionViewCell.swift
//  ShinyDay
//
//  Created by 전율 on 11/5/24.
//

import UIKit

class DetailInfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        blurView.layer.cornerRadius = 10
        blurView.clipsToBounds = true
        titleLabel.textColor = .white
        valueLabel.textColor = .white
        descriptionLabel.textColor = .white.withAlphaComponent(0.5)
    }
    
}
