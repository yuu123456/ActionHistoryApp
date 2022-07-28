//
//  EditVIewController.swift
//  ActionHistoryApp
//
//  Created by 秋山悠 on 2022/07/10.
//

import Foundation
import UIKit
import RealmSwift

class EditViewController: UIViewController {
    var day: String = ""
    var condition: String = ""
    var bodyTemp: Double = 0.0

    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var bodyTempTextField: UITextField!
    
    @IBOutlet weak var conditionSegmentedControl: UISegmentedControl!
    @IBAction func conditionSegmentedControl(_ sender: Any) {
        switch conditionSegmentedControl.selectedSegmentIndex {
                case 0:
                    condition = "体調良好"
            print(condition)
                case 1:
                    condition = "体調不良"
            print(condition)
                default:
                    print("存在しません")
        }
    }
    
    
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var destinationAddButton: UIButton!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var trafficCollection: UICollectionView!
    @IBOutlet weak var personCollection: UICollectionView!
    
    @IBAction func RegisterButton(_ sender: UIButton) {
        saveData()
        let parentVC = self.presentingViewController as! HomeViewController
        parentVC.updateView()
        self.dismiss(animated: true)
    }
    
    
    var dailyDataModel = DailyDataModel()
    var mainDataModel = MainDataModel()
    
    //ピッカー及び配列の定義
    var destinationList: [String] = ["自宅","会社"]
    var destinationPicker: UIPickerView = UIPickerView()
    var bodyTempList: [Double] = [36.5,36.6,36.7]
    var bodyTempPicker: UIPickerView = UIPickerView()
    var dayPicker = UIDatePicker()
    var timePicker = UIDatePicker()

    var trafficCollectionList: [String] = ["車","電車","バス"]
    var personCollectionList: [String] = ["妻","娘","息子","夫"]

    
    //日付フォーマット
    var dateFormat: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日(E)"
        return dateFormatter
    }
    
    //時間フォーマット
    var timeFormat: DateFormatter {
        let timeFormatter = DateFormatter()
        timeFormatter.timeZone = TimeZone.current
        timeFormatter.locale = Locale.current
        timeFormatter.dateFormat = "HH:mm"
        return timeFormatter
    }
    
    //HomeVC > EditVCに遷移時、データを表示するためのメソッド。データを受け入れる準備
    func configure(dailyData: DailyDataModel) {
        day = dailyData.day
        bodyTemp = dailyData.bodyTemp
        condition = dailyData.condition
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trafficCollection.delegate = self
        trafficCollection.dataSource = self
        personCollection.delegate = self
        personCollection.dataSource = self
        
        //ピッカー設定
        destinationPicker.delegate = self
        destinationPicker.dataSource = self
        bodyTempPicker.delegate = self
        bodyTempPicker.dataSource = self
        destinationPicker.tag = 1
        bodyTempPicker.tag = 2
        
        dayPicker.date = Date()
        dayPicker.datePickerMode = .date
        dayPicker.preferredDatePickerStyle = .wheels
        
        timePicker.date = Date()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.timeZone = TimeZone.current
        //時間をJapanese(２４時間表記）に変更
        timePicker.locale = Locale.init(identifier: "ja-JP")
        timePicker.minuteInterval = 10
        
        //決定バー設定
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem,doneItem], animated: true)
        //インプットビュー設定
        destinationTextField.inputView = destinationPicker
        destinationTextField.inputAccessoryView = toolbar
        bodyTempTextField.inputView = bodyTempPicker
        bodyTempTextField.inputAccessoryView = toolbar
        dayTextField.text = dateFormat.string(from: Date())
        dayTextField.inputView = dayPicker
        dayTextField.inputAccessoryView = toolbar
        startTimeTextField.inputView = timePicker
        startTimeTextField.inputAccessoryView = toolbar
        endTimeTextField.inputView = timePicker
        endTimeTextField.inputAccessoryView = toolbar

        
        //DatePickerの値が変更されたとき
        dayPicker.addTarget(self, action: #selector(pickerTarget(sender:)), for: .valueChanged)
        timePicker.addTarget(self, action: #selector(pickerTarget(sender:)), for: .valueChanged)
        
        

    }
    
    @objc func pickerTarget(sender: UIDatePicker) {
        if sender == dayPicker {
            dayTextField.text = dateFormat.string(from: dayPicker.date)
        } else if sender == timePicker {
            if startTimeTextField.isEditing {
                startTimeTextField.text = timeFormat.string(from: timePicker.date)
            } else if endTimeTextField.isEditing {
                endTimeTextField.text = timeFormat.string(from: timePicker.date)
            }
        }
    }
    

    //決定ボタン押下
    @objc func done() {
        view.endEditing(true)
    }
    
    //realmに保存する処理
    func saveData() {
        let realm = try! Realm()
        try! realm.write {
            dailyDataModel.day = dayTextField.text!
            dailyDataModel.bodyTemp = Double(bodyTempTextField.text!)!
            dailyDataModel.condition = condition
//            dailyDataModel.mainData.destination = "aaa"
            realm.add(dailyDataModel)
            
            mainDataModel.destination = destinationTextField.text!
            realm.add(mainDataModel)
            
        }
    }
    
}

extension EditViewController:UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == trafficCollection {
            return trafficCollectionList.count
        } else if collectionView == personCollection {
            return personCollectionList.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == trafficCollection {
            let cell = trafficCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            let trafficLabel = cell.contentView.viewWithTag(1) as! UILabel
            trafficLabel.text = trafficCollectionList[indexPath.row]
            return cell
        } else if collectionView == personCollection {
            let cell = trafficCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            let personLabel = cell.contentView.viewWithTag(1) as! UILabel
            personLabel.text = personCollectionList[indexPath.row]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension EditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    //ドラムロールの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //ドラムロールの行数
    func pickerView(_ picker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch picker.tag {
        case 1:
            return destinationList.count
        case 2:
            return bodyTempList.count
        default:
            return 0
        }
    }
    //ドラムロールの各タイトル
    func pickerView(_ picker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch picker.tag {
        case 1:
            return destinationList[row]
        case 2:
            return String(bodyTempList[row])
        default:
            return ""
        }
    }
    
    func pickerView(_ picker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch picker.tag {
        case 1:
            return self.destinationTextField.text = destinationList[row]
        case 2:
            return self.bodyTempTextField.text = String(bodyTempList[row])
        default:
            return
        }
        
    }
}
