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
    
    var dailyDataList: [DailyDataModel] = []
    
    var dayList: [String] = []
    var bodyTempList: [String] = []
    var conditionList: [String] = []
    var destinationList: [String] = []
    var startTimeList: [Date] = []
    var endTimeList: [Date] = []
    var trafficList: [String] = []
    var personList: [String] = []
    
    var sectionTitle: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logTableView.dataSource = self
        logTableView.delegate = self
        
        //カスタムセルの登録
        logTableView.register(UINib(nibName: "LogTableViewCell", bundle: nil), forCellReuseIdentifier: "LogTableViewCell")
        
        setDailyData()
    }
    
    func setDailyData() {
        let realm = try! Realm()
        let result = realm.objects(DailyDataModel.self)
        dailyDataList = Array(result)
        print("set dailyDataListの中身\(dailyDataList)")
//        var dailyDataArray = ["day": "",
//                             "bodyTemp": "",
//                             "condition": "",
//                             "mainData": [["destination": "",
//                                           "startTime": Date(),
//                                           "endTime": Date(),
//                                           "traffic": "",
//                                           "person": ""]]
//        ] as [String: Any]
//
//        for daily in result {
//            dailyDataArray["day"] = daily["day"]
//            dailyDataArray["bodyTemp"] = daily["bodyTemp"]
//            dailyDataArray["condition"] = daily["condition"]
//            destinationList = daily.mainData.map {$0.destination}
//            startTimeList = daily.mainData.map { $0.startTime}
//            endTimeList = daily.mainData.map { $0.endTime}
//            trafficList = daily.mainData.map { $0.traffic}
//            personList = daily.mainData.map { $0.person}
//        }
//        dailyDataArray["destination"] = destinationList
//        dailyDataArray["startTime"] = startTimeList
//        dailyDataArray["endTime"] = endTimeList
//        dailyDataArray["traffic"] = trafficList
//        dailyDataArray["person"] = personList
//        print(dailyDataArray)
        
//        dailyDataList = dailyDataArray
        
//        //セクションタイトルに値を反映
//        sectionTitle = dailyDataList.map({$0.day}) as NSArray
    }
    
    func updateView() {
        setDailyData()
        logTableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let targetSection = dailyDataList[section]
//        return targetSection.mainData.count
        return dailyDataList[section].mainData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //カスタムセルをTableViewに表示
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogTableViewCell", for: indexPath) as! LogTableViewCell
        cell.TimeDestinationLabel.text? = dailyDataList[indexPath.section].mainData[indexPath.row].destination
        return cell
    }
    
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        print("dailyDataList:\(dailyDataList.count)")
        return dailyDataList.count
    }
    //セクションのヘッダー
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sectionTitle[section] as? String
//        return dayList[section]
        return dailyDataList[section].day
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //インスタンス化してコード上で使用可能に
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editViewController = storyboard.instantiateViewController(identifier: "EditViewController") as! EditViewController
        
        //HomeViewControllerから遷移する際に、データを渡す処理
//        let dailyData = dailyDataList[indexPath.row]
//        editViewController.configure(dailyData: dailyData)
//        //セル選択状態の解除
//        tableView.deselectRow(at: indexPath, animated: true)
//        //編集画面に遷移
//        self.present(editViewController, animated: true, completion: nil)
    }
    
//    //スワイプでデータを削除する
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        let targetDailyData = dailyDataList[indexPath.row]
////        let targetMainData = mainDataList[indexPath.row]
//        let realm = try! Realm()
//        try! realm.write {
//            realm.delete(targetDailyData)
////            realm.delete(targetMainData)
//        }
//        dailyDataList.remove(at: indexPath.row)
////        mainDataList.remove(at: indexPath.row)
//        tableView.deleteRows(at: [indexPath], with: .automatic)
//    }
}

