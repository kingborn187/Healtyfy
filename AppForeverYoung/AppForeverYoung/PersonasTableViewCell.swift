//
//  PersonasTableViewCell.swift
//  AppForeverYoung
//
//  Created by Renato Tramontano on 24/02/17.
//  Copyright © 2017 iosparthenopedeveloper. All rights reserved.
//

import UIKit

class PersonasTableViewCell: UITableViewCell {
   
    @IBOutlet var telephone: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var surname: UILabel!
    @IBOutlet var imagePerson: UIImageView!
    
    @IBOutlet weak var BackgroundCardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imagePerson.layer.cornerRadius = 10
        imagePerson.clipsToBounds = true
        
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
