//
//  HandlerType.swift
//  ProjectQ-Components2
//
//  Created by Jeytery on 15.04.2023.
//

import Foundation

public enum HandlerType: String {
    case appear = "Appear Component"
    case data = "Data Compnent"
    case interactive = "Interactive Compnent"

    init(handler: ComponentHandler) {
        switch handler {
        case is AppearComponentHandler: self = .appear
        case is InteractiveComponentHandler: self = .interactive
        case is DataComponentHandler: self = .data
        default: self = .appear
        }
    }
}
