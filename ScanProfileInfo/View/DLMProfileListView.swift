//
//  DLMProfileListView.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/2/5.
//

import SwiftUI

struct DLMProfileListView: View {
    @EnvironmentObject var appState: AppState
    @Binding var selectedProfileUUID: String?
    private let filterType: FilterListCategory
    private let isFilterRepeat: Bool
    
    init(selectedProfileUUID: Binding<String?>, filterType: FilterListCategory, isFilterRepeat: Bool) {
        self._selectedProfileUUID = selectedProfileUUID
        self.filterType = filterType
        self.isFilterRepeat = isFilterRepeat
    }
    
    var visiableProfileList: [DLMProfileItem] {
        var profileList: [DLMProfileItem]
        switch filterType {
        case .all:
            profileList = appState.allProfileList
        case .aboutToExpire:
            profileList = appState.allProfileList.filter { $0.endDateType() == .aboutToExprire }
        case .expired:
            profileList = appState.allProfileList.filter { $0.endDateType() == .expired }
        }
        // 忽略掉 Xcode 管理的 profile
        profileList = profileList.filter { $0.isXcodeManaged != 1 }
        if isFilterRepeat {
            // 根据 applicationIdentifier和 apsEnvironment， 查找 profileList 中重复的 profile
            // Fixed-Me: 如果 profile 中读取不到 apns-environment，会导致被错认为重复的 profile
            var profileDict = [String: [DLMProfileItem]]()
            var duplicates: [DLMProfileItem] = []
            for profile in profileList {
                let applicationIdentifier = profile.applicationIdentifier.wrapNil
                let environment = profile.apsEnvironment.wrapNil
                let specialID = applicationIdentifier + environment
                if var items = profileDict[specialID] {
                    items.append(profile)
                    profileDict[specialID] = items
                } else {
                    profileDict[specialID] = [profile]
                }
            }
            
            for (_, items) in profileDict {
                if items.count > 1 {
                    duplicates.append(contentsOf: items)
                }
            }
            
            profileList = duplicates
            
            profileList.sort(by: { $0.applicationIdentifier.wrapNil.compare($1.applicationIdentifier.wrapNil) == .orderedAscending })
        } else {
            profileList.sort(by: { ($0.expirationDate ?? Date()).compare(($1.expirationDate ?? Date())) == .orderedAscending })
        }
        return profileList
    }
    
    var body: some View {
        List(visiableProfileList, selection: $selectedProfileUUID) { profileItem in
            DLMProfileListItemRow(profile: profileItem, selected: selectedProfileUUID == profileItem.uuid, appState: appState)
                .environmentObject(appState)
        }
        .listStyle(.sidebar)
    }
}
