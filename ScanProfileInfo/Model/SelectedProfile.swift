//
//  SelectedProfile.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/2/5.
//

import Foundation

enum SelectedProfile {
    case none
    case some(DLMProfileItem)
    
    init(_ optional: Optional<DLMProfileItem>) {
        switch optional {
        case .none: self = .none
        case let .some(profile): self = .some(profile)
        }
    }
    
    var asOptional: DLMProfileItem? {
        switch self {
        case .none: return .none
        case let .some(profile): return .some(profile)
        }
    }
}

extension Optional where Wrapped == SelectedProfile {
    var unwrapped: DLMProfileItem? {
        switch self {
        case Optional<SelectedProfile>.none: return Optional<DLMProfileItem>.none
        case let .some(selectedProfile): return selectedProfile.asOptional
        }
    }
}
