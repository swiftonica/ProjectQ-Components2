//
//  IntervalCompnent.swift
//  ProjectQ-Components2
//
//  Created by Jeytery on 10.04.2023.
//

import Foundation
import ProjectQ_Models

extension ComponentId {
    static let interval = ComponentId(pureNumber: 1)
}

extension Component {
    static var interval: Component {
        return Component(
            id: .interval,
            information: .init(name: "Interval", conflictedComponents: nil),
            handler: EmptyHandler()
        )
    }
    
    static func interval(input: Data) -> Component {
        guard let basicClient = ProjectQ_Components2.shared.basicClient else {
            NSLog("ProjectQ-Compnents2: [!] Can't construct IntervalComponent due the basicClient is not configured")
            return self.interval
        }
        let handler = IntervalComponentHandler(
            basicClient: basicClient,
            input: input
        )
        return Component(
            id: .interval,
            information: .init(name: "Interval", conflictedComponents: nil),
            handler: handler
        )
    }
}
