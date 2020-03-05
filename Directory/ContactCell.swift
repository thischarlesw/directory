//
//  ContactCell.swift
//  Directory
//
//  Created by Charles Wang on 3/4/20.
//  Copyright © 2020 Charles Wang. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var employmentLabel: UILabel!

    var uuid: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
