//
//  DLMScanVM.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/1/12.
//

import Cocoa
import SwiftUI

class DLMScanVM: ObservableObject {
    
    // MARK: - properties
    @Published private(set) var profileDirUrl: URL?
    @Published private(set) var profileItemList: [DLMProfileItem] = []
    @Published var selectedItem: DLMProfileItem? = nil
    @Published var selectedItems: Set<DLMProfileItem> = [] 
    
    @Published var showStyle: String = "list"
    
    private(set) lazy var fileUtil = DLMFileUtil()
    private(set) lazy var eventUtil = DLMEventUtil()
    
    // MARK: - utils
    func updateProfileItemList() {
        guard let profileDirUrl = profileDirUrl else {
            return
        }
        let profileItemList = fileUtil.readFile(at: profileDirUrl)
        updateProfileItemList(profileItemList)
    }

    func choosePath(completion: (() -> Void)? = nil) {
        let panel = NSOpenPanel()
        panel.directoryURL = URL(fileURLWithPath: String.defaultProvisiongProfileDir)
        panel.title = String(localized: "chooseProvisioningProfiles")
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.canCreateDirectories = true
        panel.allowsMultipleSelection = false
        panel.begin { result in
            if result == .OK {
                self.profileDirUrl = panel.url
                completion?()
            }
        }
    }
    
    func updateProfileItemList(_ list: [DLMProfileItem]) {
        profileItemList = list
    }
    
    // MARK: - action
    func delete(_ listItem: DLMProfileItem) {
        guard let fileURL = fileURL(with: listItem) else { return }
        fileUtil.removeFile(at: fileURL)
        updateProfileItemList()
    }
    
    func showInFinder(with listItem: DLMProfileItem) {
        guard let fileURL = fileURL(with: listItem) else { return }
        if fileURL.isDirectory {
            NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: fileURL.path)
        } else {
            NSWorkspace.shared.activateFileViewerSelecting([fileURL])
        }
    }
    
    func addAlert(with listItem: DLMProfileItem) {
        let type = listItem.endDateType()
        guard type != .expired else {
            return
        }
        
        let title = listItem.name.wrapNil + "快到期了"
        let notes = "描述文件: " + listItem.name.wrapNil + " " + listItem.rightTintStr()
        guard let endDate = listItem.expirationDate else {
            return
        }
        let startDate = Calendar.current.date(byAdding: .day, value: -1, to:endDate) ?? Date()
        var alertDate: Date = Date() // default is now
        if type == .normal {
            // 30 days before
            alertDate = Calendar.current.date(byAdding: .month, value: -1, to: endDate) ?? Date()
        }
        eventUtil.createCalendarEvent(with: title, notes: notes, startDate: startDate, endDate: endDate, alarmDate: alertDate)
    }
    // MARK: - other
    fileprivate func fileURL(with listItem: DLMProfileItem) -> URL? {
        guard let profileDirUrl else { return profileDirUrl }
        let fileURL = profileDirUrl.appending(path: "\(listItem.uuid.wrapNil).mobileprovision")
        return fileURL
    }
}
