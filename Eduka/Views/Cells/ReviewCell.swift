//
//  ReviewCell.swift
//  Eduka
//
//  Created by Celestial on 03/01/25.
//

import UIKit

class ReviewCell: UICollectionViewCell {

    @IBOutlet weak var reviewProfileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        reviewProfileImage.layer.cornerRadius = reviewProfileImage.frame.width / 2
        // Initialization code
    }


}
