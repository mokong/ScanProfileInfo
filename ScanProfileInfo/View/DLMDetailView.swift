//
//  DLMDetailView.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/1/18.
//

import SwiftUI

struct DLMDetailView: View {
    var detailItem: DLMProfileDetailItem
    
    func singleRowView(leftStr: String, rightStr: String) -> some View {
        GeometryReader { geometry in
            HStack(alignment: .center) {
                let leftWidth = geometry.size.width * 0.45
                let rightWidth = geometry.size.width * 0.55
                Text(leftStr + ": ")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.secondary)
                    .frame(width: leftWidth, alignment: .trailing)

                Text(rightStr)
                    .font(.title3)
                    .frame(width: rightWidth, alignment: .leading)
                    .textSelection(.enabled)
            }
        }
    }
    
    var body: some View {
        VStack {
            List {
                Section {
                    VStack(alignment: .center, spacing: 5) {
                        Text(detailItem.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        Text(detailItem.expiredStr)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(detailItem.expiredColor)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    }
                }
                
                ForEach(detailItem.sectionItems, id: \.id) { sectionItem in
                    Section {
                        ForEach(sectionItem.columnItems, id: \.id) { columnItem in
                            singleRowView(leftStr: columnItem.leftStr, rightStr: columnItem.rightStr)
                        }
                    } header: {
                        if sectionItem.header.isEmpty {
                            EmptyView()
                        } else {
                            VStack {
                                Divider()
                                Text(sectionItem.header)
                                    .font(.title)
                                    .foregroundStyle(.black)
                                    .padding(.leading, 30)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                }
            }
        }
        // 添加到日历，在文件夹中显示，删除
//            HStack {
//                Button {
//                    refreshAction()
//                } label: {
//                    HStack {
//                        Image(systemName: "arrow.clockwise")
//                        Text("refresh")
//                    }
//                }
//                
//                Spacer()
//                
//                Button {
//                    settingsAction()
//                } label: {
//                    HStack {
//                        Image(systemName: "gearshape")
//                        Text("settings")
//                    }
//                }
//            }
//        }
    }
}
