//
//  DLMUnselectedView.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/2/5.
//

import SwiftUI

struct DLMUnselectedView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            Spacer()
            Button("chooseProvisioningProfiles") {
                appState.choosePath()
            }

            Text("NoMobileProvisionSelected")
                .font(.title)
                .foregroundColor(.secondary)
            Spacer()
            
            if !appState.allProfileList.isEmpty {
                Button("删除所有过期描述文件") {
                    appState.deleteAllExpiredProfile()
                }
            }
            
        }
    }
}
