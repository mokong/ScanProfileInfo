//
//  DLMProfileDetailItem.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/1/18.
//

import Foundation
import SwiftUI

struct DLMProfileDetailItem {
    var title: String
    var expiredStr: String
    var expiredColor: Color
    var sectionItems: [DLMProfileDetailSectionItem]
    
    static func detailItem(from listItem: DLMProfileItem) -> DLMProfileDetailItem {
        let section1: DLMProfileDetailSectionItem = DLMProfileDetailItem.sectionItem1(from: listItem)
        let section2 = DLMProfileDetailItem.sectionItem2(from: listItem)
        var sectionItems: [DLMProfileDetailSectionItem] = [section1, section2]
        if let section3 = DLMProfileDetailItem.sectionItem3(from: listItem) {
            sectionItems.append(section3)
        }
        
        let detailItem = DLMProfileDetailItem(title: listItem.name.wrapNil,
                                              expiredStr: listItem.rightTintStr(),
                                              expiredColor: listItem.rightTintColor(),
                                              sectionItems: sectionItems)
        return detailItem
    }
    
    static func sectionItem3(from listItem: DLMProfileItem) -> DLMProfileDetailSectionItem? {
        var section3Columns: [DLMProfileDetailColumnItem] = []
        if let provisionedDevices = listItem.provisionedDevices {
            for device in provisionedDevices {
                DLMProfileDetailItem.appendSectionItem(with: "Device ID", rightStr: device, columns: &section3Columns)
            }
        }
        
        if section3Columns.count > 0 {
            let section: DLMProfileDetailSectionItem = DLMProfileDetailSectionItem(header: "PROVISIONED DEVICES", columnItems: section3Columns)
            return section
        }
        return nil
    }
    
    static func sectionItem2(from listItem: DLMProfileItem) -> DLMProfileDetailSectionItem {
        var section2Columns: [DLMProfileDetailColumnItem] = []
        DLMProfileDetailItem.appendSectionItem(with: "Team", rightStr: listItem.teamName, columns: &section2Columns)
        DLMProfileDetailItem.appendSectionItem(with: "TeamID", rightStr: listItem.teamIDStr(), columns: &section2Columns)
        DLMProfileDetailItem.appendSectionItem(with: "keychain-access-groups", rightStr: listItem.keychainAccessGroups, columns: &section2Columns)
        DLMProfileDetailItem.appendSectionItem(with: "aps-environment", rightStr: listItem.apsEnvironment, columns: &section2Columns)
        DLMProfileDetailItem.appendSectionItem(with: "com.apple.developer.associated-domains", rightStr: listItem.associatedDomains, columns: &section2Columns)
        DLMProfileDetailItem.appendSectionItem(with: "get-task-allow", rightStr: listItem.getTaskAllow, columns: &section2Columns)
        DLMProfileDetailItem.appendSectionItem(with: "com.apple.security.application-groups", rightStr: listItem.applicationGroupStr(), columns: &section2Columns)
        let section: DLMProfileDetailSectionItem = DLMProfileDetailSectionItem(header: "ENTITLEMENTS", columnItems: section2Columns)
        return section
    }
    
    static func sectionItem1(from listItem: DLMProfileItem) -> DLMProfileDetailSectionItem {
        var section1Columns: [DLMProfileDetailColumnItem] = []
        DLMProfileDetailItem.appendSectionItem(with: "App ID Name", rightStr: listItem.name, columns: &section1Columns)
        DLMProfileDetailItem.appendSectionItem(with: "App ID", rightStr: listItem.applicationIdentifier, columns: &section1Columns)
        DLMProfileDetailItem.appendSectionItem(with: "UUID", rightStr: listItem.uuid, columns: &section1Columns)

        DLMProfileDetailItem.appendSectionItem(with: "Platform", rightStr: listItem.platformStr(), columns: &section1Columns)
        DLMProfileDetailItem.appendSectionItem(with: "IsXcodeManaged", rightStr: listItem.xcodeManagedDisplayStr(), columns: &section1Columns)
        DLMProfileDetailItem.appendSectionItem(with: "Provisions All Devices", rightStr: listItem.provisionsAllDevicesStr(), columns: &section1Columns)

        DLMProfileDetailItem.appendSectionItem(with: "CreationDate", rightStr: listItem.formatDateStr(listItem.creationDate ?? Date()), columns: &section1Columns)
        DLMProfileDetailItem.appendSectionItem(with: "ExpirationDate", rightStr: listItem.formatDateStr(listItem.expirationDate ?? Date()), columns: &section1Columns)
        let section1: DLMProfileDetailSectionItem = DLMProfileDetailSectionItem(header: "", columnItems: section1Columns)
        return section1
    }
    
    static func appendSectionItem(with leftStr: String, rightStr: String?, columns: inout [DLMProfileDetailColumnItem]) {
        guard !rightStr.isNilOrEmpty else {
            return
        }
        let columnItem = DLMProfileDetailColumnItem(leftStr: leftStr, rightStr: rightStr!)
        columns.append(columnItem)
    }
}

struct DLMProfileDetailSectionItem: Identifiable {
    var id = UUID()
    var header: String
    var columnItems: [DLMProfileDetailColumnItem]
}
