//
//  String_Extensions.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/1/18.
//

import Foundation

extension String {
    static let defaultProvisiongProfileDir = "~/Library/MobileDevice/Provisioning Profiles/"
}

func localizeString(_ key: String, comment: String = "") -> String {
    if #available(macOS 12, *) {
        return String(localized: String.LocalizationValue(key))
    } else {
        return NSLocalizedString(key, comment: comment)
    }
}
