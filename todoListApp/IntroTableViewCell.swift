//
//  IntroTableViewCell.swift
//  todoListApp
//
//  Created by Tennyson Pinheiro on 9/28/17.
//  Copyright © 2017 Tennyson Pinheiro. All rights reserved.
//

import UIKit

class IntroTableViewCell: UITableViewCell {


    
 

    @IBOutlet weak var txtDetailsTask: UILabel!
    @IBOutlet weak var txtLabelShow: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
