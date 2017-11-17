//
//  ConversionCell.swift
//  FishAhoy!
//
//  Created by Ursula Cruz on 11/14/17.
//  Copyright © 2017 Ursula Cruz. All rights reserved.
//

import UIKit

class ConversionCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageBubble: UIView!
    
    // create the message bubble
    override func layoutSubviews() {
        super.layoutSubviews()
        messageBubble.layer.cornerRadius = 10
        messageBubble.layer.masksToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
