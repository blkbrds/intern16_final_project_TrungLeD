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
}
