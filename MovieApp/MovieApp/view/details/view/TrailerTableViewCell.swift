//
//  TrailerTableViewCell.swift
//  MovieApp
//
//  Created by JETS Mobile Lab - 9 on 5/16/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import UIKit

class TrailerTableViewCell: UITableViewCell {
    @IBOutlet weak var trailerLabel: UILabel!
    
    @IBOutlet weak var trailerImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
