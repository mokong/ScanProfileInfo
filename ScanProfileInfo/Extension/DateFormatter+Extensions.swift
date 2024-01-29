//
//  DateFormatter+Extensions.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/1/17.
//

import Foundation

extension DateFormatter {
    enum DLMDateFormatStr: String {
        case standard = "yyyy-MM-dd HH:mm:ss"
        case standardT = "yyyy-MM-dd'T'HH:mm:ssZ"
        case standardZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case yearMonthDay = "yyyy-MM-dd"
    }
    
    static let standardZ: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DLMDateFormatStr.standardZ.rawValue
        return formatter
    }()
    
    static let standardT: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DLMDateFormatStr.standardT.rawValue
        return formatter
    }()
    
    static let standard: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DLMDateFormatStr.standard.rawValue
        return formatter
    }()
    
    static let yearMonthDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DLMDateFormatStr.yearMonthDay.rawValue
        return formatter
    }()
}
