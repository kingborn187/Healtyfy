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
    @IBOutlet weak var BackgroundCardView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageNot.layer.cornerRadius = 10
        imageNot.clipsToBounds = true
        
        BackgroundCardView.backgroundColor = UIColor(hue: 0.1056, saturation: 0.97, brightness: 0.96, alpha: 1.0)
        contentView.backgroundColor = UIColor(hue: 0.0611, saturation: 1, brightness: 0.95, alpha: 1.0)
        BackgroundCardView.layer.cornerRadius = 15.0
        BackgroundCardView.layer.masksToBounds = false
        BackgroundCardView.layer.shadowColor = UIColor(hue: 0.0889, saturation: 1, brightness: 0.64, alpha: 0.5).cgColor
        BackgroundCardView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        BackgroundCardView.layer.shadowOpacity = 0.9
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
