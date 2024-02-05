//
//  DLMProfileListItemRow.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/2/5.
//

import SwiftUI

struct DLMProfileListItemRow: View {
    let profile: DLMProfileItem
    let selected: Bool
    var appState: AppState

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(profile.name.wrapNil)
                    .foregroundStyle(.black)
                    .font(.body)
                
                Text(profile.rightTintStr())
                    .foregroundStyle(profile.rightTintColor())
                    .font(.title3)
            }
            
            Spacer()
            
            rightControl(for: profile)
        }
        .contextMenu {
            DLMRevealButton(profile: profile)
            
            if profile.endDateType() != .expired {
                DLMAddAlertButton(profile: profile)
            }

            Divider()

            DLMDeleteButton(profile: profile)
        }
    }
    
    @ViewBuilder
    private func rightControl(for profile: DLMProfileItem) -> some View {
        let alertState = profile.alertState()
        if alertState == .delete {
            Button("Delete") { appState.delete(profile) }
                .textCase(.uppercase)
                .buttonStyle(DLMAppStoreButtonStyle(primary: true, highlighted: true))
                .help("Delete")
        } else {
            Button("AddAlert") { appState.addAlert(profile) }
                .textCase(.uppercase)
                .buttonStyle(DLMAppStoreButtonStyle(primary: false, highlighted: false))
                .help("AddAlert")
                .disabled(alertState == .added)
        }
    }
}
