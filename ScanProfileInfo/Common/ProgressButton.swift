//
//  ProgressButton.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/2/4.
//

import SwiftUI

struct ProgressButton<Label: View>: View {
    let isInProgress: Bool
    let action: () -> Void
    let label: () -> Label
    
    init(isInProgress: Bool, action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Label) {
        self.isInProgress = isInProgress
        self.action = action
        self.label = label
    }
    
    var body: some View {
        Button(action: action) {
            label()
                .isHidden(isInProgress)
                .overlay(
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(x: 0.5, y: 0.5, anchor: .center)
                        .isHidden(!isInProgress)
                    )
        }
        .disabled(isInProgress)
    }
}
