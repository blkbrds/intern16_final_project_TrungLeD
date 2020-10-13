//
//  DateExt.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/1/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
extension Date {
    func convertToString(dateFormat formatType: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType.rawValue
        let newDate: String = dateFormatter.string(from: self)
        return newDate
    }
    
    static func calculateDate(day: Int, month: Int, year: Int, hour: Int, minute: Int) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "es_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let calculateDate = formatter.date(from: "\(year)/\(month)/\(day) \(hour):\(minute)") ?? Date()
        return calculateDate
    }
    func getDate() -> String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
     
        return ("\(year)-\(month)-\(day)")
    }
    
    func getTime() -> (hour: Int, minute: Int) {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        return (hour, minute)
    }
}
