//
//  DLMListItemRowView.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/1/19.
//

import SwiftUI

struct DLMListItemRowView: View {
    var listItem: DLMProfileItem
    var deleteAction: () -> Void
    var showInFinderAction: () -> Void
    var addAlertAction: () -> Void
    
    var body: some View {
        HStack(content: {
            Text(listItem.name.wrapNil)
                .foregroundStyle(.black)
                .font(.body)
            Spacer()
            
            Text(listItem.rightTintStr())
                .foregroundStyle(listItem.rightTintColor())
                .font(.title3)
            
            Button {
                
            } label: {
                Text(listItem.rightBtnStr())
                    .font(.body)
            }
        })
        .contextMenu {
            Section {
                Button {
                    showInFinderAction()
                } label: {
                    Label("ShowInFiner", systemImage: "folder").labelStyle(.titleAndIcon)
                }
                
                if listItem.endDateType() != .expired {
                    Button {
                        addAlertAction()
                    } label: {
                        Label("addAlert", systemImage: "calendar").labelStyle(.titleAndIcon)
                    }
                }
            }
            
            Section {
                Button {
                    deleteAction()
                } label: {
                    Label("Delete", systemImage: "trash").labelStyle(.titleAndIcon)
                }
            }
        }
    }
}
