//
//  DLMMainView.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/1/12.
//

import SwiftUI

struct DLMMainView: View {
    @ObservedObject var vm = DLMScanVM()
    
    func defaultView() -> some View {
        return Button("chooseProvisioningProfiles") {
            vm.choosePath() {
                vm.updateProfileItemList()
            }
        }
        .frame(width: 400, height: 400)
    }
    
    func listView() -> some View {
        return List(vm.profileItemList, id: \.uuid, selection: $vm.selectedItems) { (listItem: DLMProfileItem) in
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
    
    var body: some View {
        NavigationStack {
            VStack {
                if vm.profileItemList.count == 0 {
                    defaultView()
                } else {
                    listView()
                }
                
                DLMMainFooterView {
                    vm.updateProfileItemList()
                } settingsAction: {
                    
                }
            }
            .toolbar {
//                ToolbarItem(id: "筛选", placement: .primaryAction) {
//                    Button(action: {
//                        
//                    }, label: {
//                        HStack {
//                            Image(systemName: "line.3.horizontal.decrease")
//                            Text("筛选")
//                        }
//                    })
//                }
//                
//                ToolbarItem(id: "picker", placement: .primaryAction) {
//                    Picker("AAAA", selection: $vm.showStyle) {
//                        Text("list")
//                        Text("grid")
//                    }
//                    .pickerStyle(MenuPickerStyle())
//                    .padding()
//                }
//               
                Menu(content: {
                    Text("list")
                    Text("grid")

//                    Picker("Destination", selection: $vm.showStyle) {
//                        Text("list")
//                        Text("grid")
//                        
//                    }.pickerStyle(.menu)
                    
                },
                                 label: { Label ("Destination", systemImage: "text.justify") })
            }
            .padding()
        }
    }
}
