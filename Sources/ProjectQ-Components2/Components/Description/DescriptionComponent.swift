//
//  DescriptionComponent.swift
//  ProjectQ-Components2
//
//  Created by Jeytery on 11.04.2023.
//

import Foundation

public extension ComponentId {
    static let description = ComponentId(pureNumber: 2)
}

public extension Component {
    static var description: Component {
        return Component(
            id: .interval,
            information: .init(name: "Description", conflictedComponents: nil),
            handler: EmptyHandler()
        )
    }
    
    static func description(input: Data) -> Component {
        let handler = DescriptionComponentHandler(input: input)
        return Component(
            id: .interval,
            information: .init(name: "Description", conflictedComponents: nil),
            handler: handler
        )
    }
    
    static func description(input: DescriptionComponentHandlerInput) -> Component {
        guard let inputData = try? JSONEncoder().encode(input) else {
            NSLog("ProjectQ-Compnents2: [!] Can't construct DescriptionComponent due the JSONEncoder error")
            return self.description
        }
        
        let handler = DescriptionComponentHandler(input: inputData)
        return Component(
            id: .interval,
            information: .init(name: "Description", conflictedComponents: nil),
            handler: handler
        )
    }
}
