//
//  ProgressTableViewCell.swift
//  Eduka
//
//  Created by Celestial on 05/01/25.
//

import UIKit

class ProgressTableViewCell: UITableViewCell {

    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var courseProgress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        courseTitle.textColor = .white
        courseProgress.textColor = .white
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
