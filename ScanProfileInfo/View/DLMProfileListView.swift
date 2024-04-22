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
        if isFilterRepeat {
            let crossReference = Dictionary(grouping: profileList, by: \.applicationIdentifier)
            let duplicates = crossReference
                .filter { $1.count > 1 }
                .compactMap { $0.1 }
            var tempList: [DLMProfileItem] = []
            duplicates.forEach { list in
                list.forEach { item in
                    tempList.append(item)
                }
            }
            profileList = tempList
        }
        profileList.sort(by: { ($0.expirationDate ?? Date()).compare(($1.expirationDate ?? Date())) == .orderedAscending })
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
