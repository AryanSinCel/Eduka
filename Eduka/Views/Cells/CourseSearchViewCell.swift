//
//  CourseSearchViewCell.swift
//  Eduka
//
//  Created by Celestial on 10/01/25.
//

import UIKit

class CourseSearchViewCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var courseTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
