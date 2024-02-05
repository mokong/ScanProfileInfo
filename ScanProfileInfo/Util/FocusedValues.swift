//
//  FocusedValues.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/2/5.
//

import Foundation
import SwiftUI

struct FocusedProfileKey : FocusedValueKey {
    typealias Value = SelectedProfile
}


extension FocusedValues {
    var selectedProfile: FocusedProfileKey.Value? {
        get { self[FocusedProfileKey.self] }
        set { self[FocusedProfileKey.self] = newValue }
    }
}
