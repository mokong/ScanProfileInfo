//
//  Date_Extensions.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/1/18.
//

import Foundation

extension Date {
    func dateToString(format: DateFormatter.DLMDateFormatStr) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
    
    func dateToString(formatStr: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatStr
        return formatter.string(from: self)
    }
}
