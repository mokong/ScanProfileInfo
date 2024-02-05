//
//  AppState.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/2/4.
//

import AppKit
import Combine

class AppState: ObservableObject {
    
    @Published var updatePublisher: AnyCancellable?
    var isUpdateing: Bool { updatePublisher != nil }
    
    private(set) lazy var fileUtil = DLMFileUtil()
    private(set) lazy var eventUtil = DLMEventUtil()

    @Published var allProfileList: [DLMProfileItem] = []
    @Published var selectedProfileUrl: URL? {
        didSet {
            updateAllProfileList()
        }
    }
    
}

extension AppState {
    func choosePath() {
        let panel = NSOpenPanel()
        panel.directoryURL = URL(fileURLWithPath: String.defaultProvisiongProfileDir)
        panel.title = String(localized: "chooseProvisioningProfiles")
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.canCreateDirectories = true
        panel.allowsMultipleSelection = false
        panel.begin { result in
            if result == .OK {
                self.selectedProfileUrl = panel.url
            }
        }
    }
}

extension AppState {
    func updateAllProfileList() {
        guard let profileDirUrl = selectedProfileUrl else {
            return
        }
        let profileItemList = fileUtil.readFile(at: profileDirUrl)
        allProfileList = profileItemList
    }

    func reveal(_ profile: DLMProfileItem) {
        guard let fileURL = fileURL(with: profile) else { return }
        if fileURL.isDirectory {
            NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: fileURL.path)
        } else {
            NSWorkspace.shared.activateFileViewerSelecting([fileURL])
        }
    }
    
    func copyPath(_ profile: DLMProfileItem) {
        guard let fileURL = fileURL(with: profile) else { return }

        NSPasteboard.general.declareTypes([.URL, .string], owner: nil)
        NSPasteboard.general.writeObjects([fileURL as NSURL])
        NSPasteboard.general.setString(fileURL.absoluteString, forType: .string)
    }
    
    func select(_ profile: DLMProfileItem) {
        
    }
    
    func delete(_ profile: DLMProfileItem) {
        guard let fileURL = fileURL(with: profile) else { return }
        fileUtil.removeFile(at: fileURL)
        updateAllProfileList()
    }
    
    func addAlert(_ profile: DLMProfileItem) {
        let type = profile.endDateType()
        guard type != .expired else {
            return
        }
        
        let title = profile.name.wrapNil + "快到期了"
        let notes = "描述文件: " + profile.name.wrapNil + " " + profile.rightTintStr()
        guard let endDate = profile.expirationDate else {
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
    
    fileprivate func fileURL(with listItem: DLMProfileItem) -> URL? {
        guard let selectedProfileUrl else { return selectedProfileUrl }
        let fileURL = selectedProfileUrl.appending(path: "\(listItem.uuid.wrapNil).mobileprovision")
        return fileURL
    }
}

extension AppState {
    func update() {
        guard !isUpdateing else { return }
        
        
    }
}
