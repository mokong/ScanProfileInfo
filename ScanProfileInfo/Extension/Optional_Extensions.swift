//
//  Optional_Extensions.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/1/18.
//

import Foundation

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}

extension Optional where Wrapped == String {
    var wrapNil: String {
        if let self = self {
            return self
        } else {
            return ""
        }
    }
    
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
