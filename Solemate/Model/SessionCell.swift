//
//  SessionCell.swift
//  Solemate
//
//  Created by Steven Tran on 5/15/19.
//  Copyright © 2019 SolemateInc. All rights reserved.
//

import UIKit

class SessionCell: UITableViewCell {

    
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.backgroundColor = UIColor.init(displayP3Red: 0.48, green: 0.68, blue: 1.0, alpha: 1.0)
        containerView.layer.cornerRadius = 10
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
