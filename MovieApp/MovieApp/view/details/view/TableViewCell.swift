//
//  TableViewCell.swift
//  MovieApp
//
//  Created by JETS Mobile Lab on 5/15/19.
//  Copyright © 2019 Jets. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
