//
//  SmallIntervalComponent.swift
//  ProjectQ-Components2
//
//  Created by Jeytery on 15.04.2023.
//

import Foundation

public extension ComponentId {
    static let smallInterval = ComponentId(pureNumber: 3)
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
        let handler = IntervalComponentHandler(input: input)
        return Component(
            id: .smallInterval,
            information: .init(name: "Small Interval", conflictedComponents: nil),
            handler: handler
        )
    }
    
    static func smallInterval(input: IntervalComponentHandlerInput) -> Component {
        guard let inputData = try? JSONEncoder().encode(input) else {
            NSLog("ProjectQ-Compnents2: [!] Can't construct SmallIntervalComponent due the JSONEncoder error")
            return self.smallInterval
        }
        
        let handler = IntervalComponentHandler(input: inputData)
        return Component(
            id: .interval,
            information: .init(name: "Interval", conflictedComponents: nil),
            handler: handler
        )
    }
}
