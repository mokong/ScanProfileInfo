//
//  View+IsHidden.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/2/4.
//

import SwiftUI

extension View {
    @ViewBuilder
    func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}
