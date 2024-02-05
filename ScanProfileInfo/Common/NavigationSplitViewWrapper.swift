//
//  NavigationSplitViewWrapper.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/2/4.
//

import SwiftUI

struct NavigationSplitViewWrapper<Sidebar, Detail>: View where Sidebar: View, Detail: View {
    private var sidebar: Sidebar
    private var detail: Detail
    
    init(
        @ViewBuilder sidebar: () -> Sidebar,
        @ViewBuilder detail: () -> Detail) {
        self.sidebar = sidebar()
        self.detail = detail()
    }
    
    var body: some View {
        if #available(iOS 16, macOS 13, tvOS 16, watchOS 9, visionOS 1, *) {
            // Use the latest API available
            NavigationSplitView {
                if #available(macOS 14, *) {
                    sidebar 
                        .toolbar(removing: .sidebarToggle)
                } else {
                    sidebar
                }
            } detail: {
                detail
            }
        } else {
            // Fallback on earlier versions
            NavigationView {
                sidebar
                detail
            }
            .navigationViewStyle(.columns)
        }
    }
}
