//
//  DLMContextMenuButton.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/2/5.
//

import SwiftUI

struct DLMRevealButton: View {
    @EnvironmentObject var appState: AppState
    let profile: DLMProfileItem?
    
    var body: some View {
        Button(action: reveal) {
            Text("Show In Finder")
        }
        .help("RevealInFinder")
    }
    
    private func reveal() {
        guard let profile = profile else { return }
        appState.reveal(profile)
    }
}

struct DLMCopyPathButton: View {
    @EnvironmentObject var appState: AppState
    let profile: DLMProfileItem?
    
    var body: some View {
        Button(action: copyPath) {
            Text("CopyPath")
        }
        .help("CopyPath")
    }
    
    private func copyPath() {
        guard let profile = profile else { return }
        appState.copyPath(profile)
    }
}

struct DLMSelectButton: View {
    @EnvironmentObject var appState: AppState
    let profile: DLMProfileItem?
    
    var body: some View {
        Button(action: select) {
            if profile?.selected == true {
                Text("Active")
            } else {
                Text("MakeActive")
            }
        }
        .disabled(profile?.selected != false)
        .help("Select")
    }
    
    private func select() {
        guard let profile = profile else { return }
        appState.select(profile)
    }
}

struct DLMDeleteButton: View {
    @EnvironmentObject var appState: AppState
    let profile: DLMProfileItem?
    
    var body: some View {
        Button(action: delete) {
            Text("Delete")
        }
        .help("Delete")
    }
    
    private func delete() {
        guard let profile = profile else { return }
        appState.delete(profile)
    }
}

struct DLMAddAlertButton: View {
    @EnvironmentObject var appState: AppState
    let profile: DLMProfileItem?
    
    var body: some View {
        Button(action: addAlert) {
            Text("Add Alert")
        }
        .help("AddAlert")
    }
    
    private func addAlert() {
        guard let profile = profile else { return }
        appState.addAlert(profile)
    }
}
