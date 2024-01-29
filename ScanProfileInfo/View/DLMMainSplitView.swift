//
//  DLMMainSplitView.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/1/18.
//

import SwiftUI

struct DLMMainSplitView: View {
    @ObservedObject var vm = DLMScanVM()
    
    @State private var visibility: NavigationSplitViewVisibility = .doubleColumn
    @State private var selectedSideBarItem: DLMProfileItem?
    @State private var selectedItem: DLMProfileItem?
    
    func defaultView() -> some View {
        return Button("chooseProvisioningProfiles") {
            vm.choosePath() {
                vm.updateProfileItemList()
            }
        }
        .frame(width: 400, height: 400)
    }
        
    var body: some View {
        VStack {
            if vm.profileItemList.count == 0 {
                defaultView()
            } else {
                NavigationSplitView(columnVisibility: $visibility) {
                    GeometryReader { geometry in
                        let width = geometry.size.width * 0.2
                        List {
                            ForEach(vm.profileItemList, id: \.uuid) { (listItem: DLMProfileItem) in
                                NavigationLink {
                                    let detailItem = DLMProfileDetailItem.detailItem(from: listItem)
                                    DLMDetailView(detailItem: detailItem)
                                } label: {
                                    DLMListItemRowView(listItem: listItem) {
                                        vm.delete(listItem)
                                    } showInFinderAction: {
                                        vm.showInFinder(with: listItem)
                                    } addAlertAction: {
                                        vm.addAlert(with: listItem)
                                    }
                                }
                            }
                        }
                        .navigationSplitViewColumnWidth(width)
                    }
                } detail: {
                    
                }
            }
            
            DLMMainFooterView {
                vm.updateProfileItemList()
            } settingsAction: {
                
            }
        }
        .padding()
    }
}
