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
    
    init(selectedProfileUUID: Binding<String?>, filterType: FilterListCategory) {
        self._selectedProfileUUID = selectedProfileUUID
        self.filterType = filterType
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
