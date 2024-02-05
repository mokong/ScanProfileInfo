//
//  DLMainWindow.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/2/4.
//

import SwiftUI

struct DLMainWindow: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedProfileUUID: String?
    @AppStorage("filterListCategory") private var filterType: FilterListCategory = .all
    
    private var profile: DLMProfileItem? {
        appState.allProfileList.first(where: { $0.uuid == selectedProfileUUID })
    }

    var body: some View {
        NavigationSplitViewWrapper {
            DLMProfileListView(selectedProfileUUID: $selectedProfileUUID, filterType: filterType)
                .frame(minWidth: 250)
                .layoutPriority(1)
                .mainToolbar(filterType: $filterType)
        } detail: {
            Group {
                if let profile = profile {
                    DLMDetailView(detailItem: DLMProfileDetailItem.detailItem(from: profile))
                } else {
                    DLMUnselectedView()
                }
            }
            .padding()
            .toolbar {
                
            }
        }
        .padding(.top, 0)
        .navigationSubtitle(appState.allProfileList.first { $0.uuid == selectedProfileUUID }?.name ?? "")
        .frame(minWidth: 600, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        .focusedValue(\.selectedProfile, SelectedProfile(appState.allProfileList.first { $0.uuid == selectedProfileUUID }))
    }
}
