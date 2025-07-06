//
//  ToasterType.swift
//  LumiFormApp
//
//  Created by Angélica Rodrigues on 04/07/2025.
//

import UIKit

enum ToasterType {
    case informative
    case error

    var defaultTitle: String {
        switch self {
        case .informative: return NSLocalizedString("info", comment: "")
        case .error: return NSLocalizedString("error", comment: "")
        }
    }
    
    var defaultMessage: String {
        switch self {
        case .informative: return NSLocalizedString("some_operation", comment: "")
        case .error: return NSLocalizedString("some_error", comment: "" )
        }
    }
}
