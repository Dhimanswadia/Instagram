//
//  InstaTableViewCell.swift
//  Instagram
//
//  Created by Dhiman on 1/21/16.
//  Copyright © 2016 Dhiman. All rights reserved.
//

import UIKit
import AFNetworking

class InstaTableViewCell: UITableViewCell {
    @IBOutlet var InstaImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
