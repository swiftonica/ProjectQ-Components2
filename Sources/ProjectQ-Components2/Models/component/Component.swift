//
//  File.swift
//
//
//  Created by Jeytery on 10.04.2023.
//

import Foundation

public struct ComponentInformation {
    public init(name: String, conflictedComponents: [Component]?) {
        self.name = name
        self.conflictedComponents = conflictedComponents
    }
    
    public let name: String
    public let conflictedComponents: [Component]?
}

public struct ComponentId: Equatable {
    public init(pureNumber: Int) {
        self.pureNumber = pureNumber
    }
    
    public static let none = ComponentId(pureNumber: -1)
    public let pureNumber: Int
}

public class Component {
    public init(id: ComponentId, information: ComponentInformation, handler: ComponentHandler) {
        self.id = id
        self.information = information
        self.handler = handler
    }
    
    public let id: ComponentId
    public let information: ComponentInformation
    public var handler: ComponentHandler
    
    public static func byCodableComponent(_ codableComponent: CodableComponent) -> Component? {
        switch codableComponent.pureNumber {
        case 1: return interval(input: codableComponent.handlerInput)
        case 2: return description(input: codableComponent.handlerInput)
        default: return nil
        }
    }
}

extension Component: Equatable {
    public static func == (lhs: Component, rhs: Component) -> Bool {
        return lhs.id == rhs.id
    }
}
