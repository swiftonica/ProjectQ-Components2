//
//  SmallIntervalComponent.swift
//  ProjectQ-Components2
//
//  Created by Jeytery on 15.04.2023.
//

import Foundation

public extension ComponentId {
    static let smallInterval = ComponentId(pureNumber: 100)
}

public extension Component {
    static var smallInterval: Component {
        return Component(
            id: .smallInterval,
            information: .init(name: "Small Interval", conflictedComponents: nil),
            handler: EmptyHandler()
        )
    }
    
    static func smallInterval(input: Data) -> Component {
        let handler = SmallIntervalComponentHandler(input: input)
        return Component(
            id: .smallInterval,
            information: .init(name: "Small Interval", conflictedComponents: nil),
            handler: handler
        )
    }
    
    static func smallInterval(input: SmallIntervalComponentHandlerInput) -> Component {
        guard let inputData = try? JSONEncoder().encode(input) else {
            NSLog("ProjectQ-Compnents2: [!] Can't construct SmallIntervalComponent due the JSONEncoder error")
            return self.smallInterval
        }
        
        let handler = SmallIntervalComponentHandler(input: inputData)
        return Component(
            id: .smallInterval,
            information: .init(name: "Small Interval", conflictedComponents: nil),
            handler: handler
        )
    }
}
