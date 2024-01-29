//
//  DLMMainFooterView.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/1/18.
//

import SwiftUI

struct DLMMainFooterView: View {
    var refreshAction: () -> Void
    var settingsAction: () -> Void
    
    // 刷新，设置，一键删除过期的，过滤重复的显示
    var body: some View {
        HStack() {
            Button {
                refreshAction()
            } label: {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("refresh")
                }
            }
            
            Spacer()
            
            Button {
                settingsAction()
            } label: {
                HStack {
                    Image(systemName: "gearshape")
                    Text("settings")
                }
            }
        }
    }
}
