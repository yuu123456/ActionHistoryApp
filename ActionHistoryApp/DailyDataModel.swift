//
//  DailyDataModel.swift
//  ActionHistoryApp
//
//  Created by 秋山悠 on 2022/07/10.
//

import Foundation
import RealmSwift

class DailyDataModel: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var day: String = ""
    @objc dynamic var bodyTemp: Double = 0.0
    @objc dynamic var condition: String = ""
    @objc dynamic var fake: String = ""
}
