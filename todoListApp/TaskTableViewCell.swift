//
//  TaskTableViewCell.swift
//  todoListApp
//
//  Created by Tennyson Pinheiro on 9/27/17.
//  Copyright © 2017 Tennyson Pinheiro. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDone: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var dateExpiresLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
