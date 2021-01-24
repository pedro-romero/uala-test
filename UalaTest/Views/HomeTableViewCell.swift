//
//  HomeTableViewCell.swift
//  UalaTest
//
//  Created by Pedro Iván Romero Ojeda on 1/23/21.
//  Copyright © 2021 piro. All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    static let identifier = "HomeCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        thumbnailImageView.image = nil
        nameLabel.text = ""
        categoryLabel.text = ""
    }
    
    func configure(with meal: Meal) {
        nameLabel.text = meal.strMeal
        categoryLabel.text = meal.strCategory
        if let thumbUrl = URL(string: meal.strMealThumb) {
            thumbnailImageView.kf.setImage(with: thumbUrl)
        }
    }
}
