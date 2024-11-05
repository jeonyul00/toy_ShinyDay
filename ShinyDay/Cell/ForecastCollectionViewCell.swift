//
//  ForecastCollectionViewCell.swift
//  ShinyDay
//
//  Created by 전율 on 11/4/24.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func awakeFromNib() {
        dateLabel.textColor = .white
        timeLabel.textColor = .white
        statusLabel.textColor = .white
        temperatureLabel.textColor = .white
    }
    
}
