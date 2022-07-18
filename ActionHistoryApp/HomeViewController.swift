//
//  HomeViewController.swift
//  ActionHistoryApp
//
//  Created by 秋山悠 on 2022/07/10.
//

import Foundation
import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    @IBOutlet weak var logAddButton: UIButton!
    @IBOutlet weak var logTableView: UITableView!
    
    var mainDataList: [MainDataModel] = []
    var dailyDataList: [DailyDataModel] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logTableView.dataSource = self
        setmainData()
    }
    
    func setmainData() {
        let realm = try! Realm()
        let result = realm.objects(MainDataModel.self)
        mainDataList = Array(result)
    }
}

extension HomeViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return dailyDataList.count
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "custumcell", for: indexPath) as! LogTableViewCell
//        let mainDataModel: MainDataModel = mainDataList[indexPath.row]
//        cell.TrafficCell?.text = mainDataModel.traffic
//        return cell
        
        let cell = UITableViewCell()
        let mainDataModel: MainDataModel = mainDataList[indexPath.row]
        cell.textLabel?.text = mainDataModel.destination
        return cell
    }
    
    
}
