//
//  PictureTableViewCell.swift
//  ReviewGenericsTest
//
//  Created by user on 11/6/19.
//  Copyright © 2019 Roman. All rights reserved.
//

import UIKit
import Kingfisher

class PictureTableViewCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWith(info: PhotoInfo) {
        if let pictureURL = info.url {
            self.photoImageView.kf.indicatorType = .activity
            self.photoImageView.kf.setImage(with: URL(string: pictureURL)!)
        }
        
        descriptionLabel.text = info.title
    }
    
}
