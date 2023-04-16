//
//  SmallIntervalComponentHandler.swift
//  ProjectQ-Components2
//
//  Created by Jeytery on 15.04.2023.
//

import Foundation

public struct SmallIntervalComponentHandlerInput: Codable {
    public enum IntervalType: Codable, Equatable {
        case hours
        case minutes
        case seconds
    }
    
    public let intervalType: IntervalType
    public let interval: Int
}

public class SmallIntervalComponentHandler: AppearComponentHandler {
    public func shouldAppear() -> Bool {
        guard let input = getInput() else {
            return false
        }
        
        switch input.intervalType {
        case .seconds:
            let calendar = Calendar.current
            let startDate = cache.lastDate
            let endDate = Date()

            if let seconds = getInterval(component: .second, date1: startDate, date2: endDate).second {
                if seconds >= input.interval {
                    self.cache.lastDate = Date() // <- [!] set state
                    return true
                }
            }

        case .hours:
            let calendar = Calendar.current
            let startDate = cache.lastDate
            let endDate = Date()

            if let hours = getInterval(component: .hour, date1: startDate, date2: endDate).second {
                if hours >= input.interval {
                    self.cache.lastDate = Date() // <- [!] set state
                    return true
                }
            }

        case .minutes:
            let calendar = Calendar.current
            let startDate = cache.lastDate
            let endDate = Date()

            if let minutes = getInterval(component: .minute, date1: startDate, date2: endDate).second {
                if minutes >= input.interval {
                    self.cache.lastDate = Date() // <- [!] set state
                    return true
                }
            }
        } 
        return false
    }
    
    public init(input: Data) {
        self.input = input
    }
    
    public var input: Data
    public var cache: IntervalComponentHandlerCache = .init(lastDate: Date())
    
    func getInput() -> SmallIntervalComponentHandlerInput? {
        return try? JSONDecoder().decode(
            SmallIntervalComponentHandlerInput.self,
            from: input
        )
    }
}

private extension SmallIntervalComponentHandler {
    func getInterval(
        component: Calendar.Component,
        date1: Date,
        date2: Date
    ) -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([component], from: date1, to: date2)
        return components
    }
}
