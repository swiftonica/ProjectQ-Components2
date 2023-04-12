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

public struct ComponentId {
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
    public let handler: ComponentHandler
    
    public var allComponents: [Component] = []
}
