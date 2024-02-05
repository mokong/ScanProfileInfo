//
//  FilterListCategory.swift
//  ScanProfileInfo
//
//  Created by mokong on 2024/2/4.
//

import Foundation

enum FilterListCategory: String, CaseIterable, Identifiable, CustomStringConvertible {
    case all
    case aboutToExpire
    case expired
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .all: return localizeString("All")
        case .aboutToExpire: return localizeString("AboutToExpire")
        case .expired: return localizeString("Expired")
        }
    }
}
