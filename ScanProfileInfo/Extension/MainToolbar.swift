//
//  MainToolbar.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/2/4.
//

import SwiftUI

struct MainToolbarModifier: ViewModifier {
    @EnvironmentObject var appState: AppState
    @Binding var filterType: FilterListCategory
    
    func body(content: Content) -> some View {
        content
            .toolbar { toolbar }
    }
    
    private var toolbar: some ToolbarContent {
        ToolbarItemGroup {
            ProgressButton(
                isInProgress: appState.isUpdateing,
                action: appState.update) {
                    Label("Refresh", systemImage: "arrow.clockwise")
                }
                .keyboardShortcut(KeyEquivalent("r"))
                .help("RefreshDescription")
                
            Spacer()
            
            Picker(selection: $filterType) {
                ForEach(FilterListCategory.allCases, id: \.self) {
                    Label($0.rawValue, systemImage: "line.horizontal.3.decrease.circle.fill")
                        .labelStyle(TitleAndIconLabelStyle())
                        .foregroundColor(Color.white)
                }
            } label: {
                Label("Filter", systemImage: "line.horizontal.3.decrease.circle.fill")
                    .labelStyle(TitleAndIconLabelStyle())
                    .foregroundColor(Color.red)
            }
            
//            Button {
//                switch filterType {
//                case .all:
//                    filterType = .aboutToExpire
//                case .aboutToExpire:
//                    filterType = .expired
//                case .expired:
//                    filterType = .all
//                }
//            } label: {
//                Label(filterType.rawValue, systemImage: "line.horizontal.3.decrease.circle.fill")
//                    .labelStyle(TitleAndIconLabelStyle())
//                    .foregroundColor(Color.accentColor)
//            }
//            .help("FilterAvailableDescription")

        }
    }
}

extension View {
    func mainToolbar(filterType: Binding<FilterListCategory>) -> some View {
        self.modifier(
            MainToolbarModifier(filterType: filterType)
        )
    }
}
