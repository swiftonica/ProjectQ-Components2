//
//  File.swift
//
//
//  Created by Jeytery on 10.04.2023.
//

import Foundation

public struct CodableComponent: Codable {
    public init(pureNumber: Int, handlerInput: Data) {
        self.pureNumber = pureNumber
        self.handlerInput = handlerInput
    }
    
    public let pureNumber: Int
    public let handlerInput: Data
    
    public var component: Component? {
        return Component.byCodableComponent(self)
    }
}

public extension Array where Element == CodableComponent {
    var components: [Component] {
        return self.compactMap {
            return $0.component
        }
    }
}

public struct CodableTask: Codable {
    public init(name: String, codableComponents: [CodableComponent]) {
        self.name = name
        self.codableComponents = codableComponents
    }
    
    public let name: String
    public let codableComponents: [CodableComponent]
    
    public var task: Task {
        return Task(codableTask: self)
    }
}

public extension Array where Element == CodableTask {
    var tasks: [Task] {
        return self.compactMap {
            return $0.task
        }
    }
}

public struct CodablePackage: Codable {
    public init(name: String, codableTasks: [CodableTask]) {
        self.name = name
        self.codableTasks = codableTasks
    }
    
    public let name: String
    public let codableTasks: [CodableTask]
    
    public var package: Package {
        return Package(codablePackage: self)
    }
}

public extension Array where Element == CodablePackage {
    var packages: [Package] {
        return self.compactMap {
            return $0.package
        }
    }
}
