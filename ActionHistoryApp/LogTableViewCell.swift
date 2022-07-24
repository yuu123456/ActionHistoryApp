//
//  LogTableViewCell.swift
//  ActionHistoryApp
//
//  Created by 秋山悠 on 2022/07/10.
//

import UIKit
import RealmSwift

class LogTableViewCell: UITableViewCell {
    @IBOutlet weak var TimeDestinationLabel: UILabel!
    @IBOutlet weak var TrafficLabel: UILabel!
    @IBOutlet weak var PersonLabel: UILabel!
    
    //不要
//    var dailyDataList: [DailyDataModel] = []
//    func setDailyDataModel() {
//        let realm = try! Realm()
//        let result = realm.objects(DailyDataModel.self)
//        dailyDataList = Array(result)
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
}

//extension LogTableViewCell: UITableViewDelegate {
//
//}
//
//extension LogTableViewCell: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dailyDataList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "LogTableViewCell", for: indexPath) as! LogTableViewCell
//        let dailyDataModel: DailyDataModel = dailyDataList[indexPath.row]
//        cell.TimeDestinationLabel.text? = dailyDataModel.day
//
//        return cell
//    }
//
//
//}
