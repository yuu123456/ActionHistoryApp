//
//  LogTableViewCell.swift
//  ActionHistoryApp
//
//  Created by 秋山悠 on 2022/07/10.
//

import UIKit

class LogTableViewCell: UITableViewCell {
    @IBOutlet weak var TimeDestinationCell: UILabel!
    @IBOutlet weak var TrafficCell: UILabel!
    @IBOutlet weak var PersonCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
