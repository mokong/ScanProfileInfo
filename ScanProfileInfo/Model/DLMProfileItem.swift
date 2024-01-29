//
//  DLMProfileItem.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/1/17.
//

import Foundation
import Cocoa
import SwiftUI

enum DLMProfileEndDateType {
    case expired
    case aboutToExprire
    case normal
}

enum DLMProfileRightBtnType {
    case delete
    case addAlert
}

struct DLMProfileItem: Codable, Hashable {
    var creationDate: Date?
    var teamName: String?
    var name: String?
    var uuid: String?
    var teamIdentifier: [String]?
    var applicationIdentifier: String?
    var isXcodeManaged: Int?
    var platform: [String]?
    var expirationDate: Date?
    
//    var entitlements: [String: Any]?
    var keychainAccessGroups: String?
    var apsEnvironment: String?
    var associatedDomains: String?
    var getTaskAllow: String?
    var provisionedDevices: [String]?
    var provisionsAllDevices: Bool?
    var applicationGroups: [String]?
        
    static func profileItem(from infoDic: [String: Any]) -> DLMProfileItem {
        var product: DLMProfileItem = DLMProfileItem()
        product.creationDate = infoDic["CreationDate"] as? Date
        product.teamName = infoDic["TeamName"] as? String
        product.name = infoDic["Name"] as? String
        product.uuid = infoDic["UUID"] as? String
        product.teamIdentifier = infoDic["TeamIdentifier"] as? [String]
        product.provisionedDevices = infoDic["ProvisionedDevices"] as? [String]
        product.provisionsAllDevices = infoDic["ProvisionsAllDevices"] as? Bool
//        product.entitlements = infoDic["Entitlements"] as? [String: Any]
        if let entitlementsDic: [String: Any] = infoDic["Entitlements"] as? [String: Any] {
            let applicationIdentifier = entitlementsDic["application-identifier"] as? String
            if let teamIdentifier = entitlementsDic["com.apple.developer.team-identifier"] as? String {
                product.applicationIdentifier = applicationIdentifier?.replacingOccurrences(of: "\(teamIdentifier).", with: "")
            } else {
                product.applicationIdentifier = applicationIdentifier
            }
            if let list = entitlementsDic["keychain-access-groups"] as? [String] {
                product.keychainAccessGroups = list.joined(separator: ",")
            }
            product.apsEnvironment = entitlementsDic["aps-environment"] as? String
            product.associatedDomains = entitlementsDic["com.apple.developer.associated-domains"] as? String
            product.getTaskAllow = entitlementsDic["get-task-allow"] as? Bool == true ? "true" : "false"
            product.applicationGroups = entitlementsDic["com.apple.security.application-groups"] as? [String]
        }
        product.isXcodeManaged = infoDic["IsXcodeManaged"] as? Int
        product.platform = infoDic["Platform"] as? [String]
        product.expirationDate = infoDic["ExpirationDate"] as? Date
        return product
    }
    
    fileprivate func endTimeInterval() -> TimeInterval {
        guard let expirationDate = expirationDate else {
            return 0.0
        }
        
        let currentDate = Date()
        let timeInterval = expirationDate.timeIntervalSince(currentDate)
        return timeInterval
    }
    
    func endDateType() -> DLMProfileEndDateType {
        let timeInterval = endTimeInterval()
        let monthTimeInterval = TimeInterval(24 * 60 * 60 * 30)
        if timeInterval < 0 {
            return .expired
        } else if timeInterval < monthTimeInterval {
            return .aboutToExprire
        } else {
            return .normal
        }
    }
    
    // 显示 已过期、快要过期的标签
    func rightTintStr() -> String {
        let timeInterval = endTimeInterval()
        let monthTimeInterval = TimeInterval(24 * 60 * 60 * 30)
        let twoWeekTimeInterval = TimeInterval(24 * 60 * 60 * 14)
        let oneWeekTimeInterval = TimeInterval(24 * 60 * 60 * 7)
        let oneDayTimeInterval = TimeInterval(24 * 60 * 60)
        if timeInterval < 0 {
            return String(localized: "expired")
        } else if timeInterval < oneDayTimeInterval {
            return String(localized: "expiredToday")
        } else if timeInterval < oneWeekTimeInterval {
            return String(localized: "expiresIn1Week")
        } else if timeInterval < twoWeekTimeInterval {
            return String(localized: "expiresIn2Week")
        } else if timeInterval < monthTimeInterval {
            return String(localized: "expiresInMonth")
        } else {
            let str = String(localized: "expiresInDate")
            let month = timeInterval / monthTimeInterval
            var monthInt = Int(month)
            if month - Double(monthInt) > 0.01 {
                monthInt += 1
            }
            return String(format: str, monthInt)
        }
    }
    
    func rightTintColor() -> Color {
        let type = endDateType()
        if type == .aboutToExprire ||
            type == .expired
            {
            return .red
        } else {
            return .gray
        }
    }
    
    // 已过期显示删除按钮，快要过期、未过期显示添加到日历按钮
    func rightBtnType() -> DLMProfileRightBtnType {
        let type = endDateType()
        if type == .expired {
            return .delete
        } else {
            return .addAlert
        }
    }
    
    func rightBtnStr() -> String {
        let type = rightBtnType()
        if type == .delete {
            return String(localized: "delete")
        } else {
            return String(localized: "addAlert")
        }
    }
    
    func xcodeManagedDisplayStr() -> String {
        isXcodeManaged == 1 ? "Yes" : "No"
    }
    
    func teamIDStr() -> String? {
        return teamIdentifier?.joined(separator: ", ")
    }
    
    func platformStr() -> String? {
        return platform?.joined(separator: ", ")
    }
    
    func formatDateStr(_ date: Date) -> String? {
        let dateStr = date.dateToString(format: DateFormatter.DLMDateFormatStr.standard)
        return dateStr
    }
    
    func provisionsAllDevicesStr() -> String? {
        if provisionsAllDevices == true {
            return "Yes"
        } else {
            return nil
        }
    }
    
    func applicationGroupStr() -> String? {
        return applicationGroups?.joined(separator: ",")
    }
}
