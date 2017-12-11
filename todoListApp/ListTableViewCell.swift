//
//  ListTableViewCell.swift
//  todoListApp
//
//  Created by Tennyson Pinheiro on 9/27/17.
//  Copyright © 2017 Tennyson Pinheiro. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var listNameLabel: UILabel!
    
    @IBOutlet weak var counterTasksLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
