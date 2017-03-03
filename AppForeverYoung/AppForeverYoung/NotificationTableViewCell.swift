//
//  NotificationTableViewCell.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 03/03/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet var imageNot: UIImageView!
    @IBOutlet var message: UILabel!
    @IBOutlet var sender: UILabel!
    @IBOutlet var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
