//
//  ScanProfileInfoApp.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/1/12.
//

import SwiftUI

@main
struct ScanProfileInfoApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
//            DLMMainView()
//            DLMMainSplitView()
            DLMainWindow()
                .environmentObject(appState)
        }
    }
}

// 搜索
// 显示样式
// 忽略Xcode 管理的
// 批量选择——删除、添加提醒
// 筛选——只显示将要过期的
// 筛选——只显示已过期的
