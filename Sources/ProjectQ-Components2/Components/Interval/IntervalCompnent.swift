//
//  IntervalCompnent.swift
//  ProjectQ-Components2
//
//  Created by Jeytery on 10.04.2023.
//

import Foundation

public extension ComponentId {
    static let interval = ComponentId(pureNumber: 1)
}

public extension Component {
    static var interval: Component {
        return Component(
            id: .interval,
            information: .init(name: "Interval", conflictedComponents: nil),
            handler: EmptyHandler()
        )
    }
    
    static func interval(input: Data) -> Component {
        let handler = IntervalComponentHandler(input: input)
        return Component(
            id: .interval,
            information: .init(name: "Interval", conflictedComponents: nil),
            handler: handler
        )
    }
    
    static func interval(input: IntervalComponentHandlerInput) -> Component {
        guard let inputData = try? JSONEncoder().encode(input) else {
            NSLog("ProjectQ-Compnents2: [!] Can't construct IntervalComponent due the JSONEncoder error")
            return self.interval
        }
        
        let handler = IntervalComponentHandler(input: inputData)
        return Component(
            id: .interval,
            information: .init(name: "Interval", conflictedComponents: nil),
            handler: handler
        )
    }
}
