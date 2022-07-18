//
//  MainDataModel.swift
//  ActionHistoryApp
//
//  Created by 秋山悠 on 2022/07/10.
//

import Foundation
import RealmSwift

class MainDataModel: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var destination: String = "会社"
    @objc dynamic var startTime: Date = Date()
    @objc dynamic var endTime: Date = Date()
    @objc dynamic var traffic: String = "車"
    @objc dynamic var person: String = "母"
}
