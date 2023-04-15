//
//  IntervalCompnoentHandler.swift
//  ProjectQ-Components2
//
//  Created by Jeytery on 10.04.2023.
//

import Foundation

fileprivate func dayNumberOfWeek(date: Date) -> Int? {
    return Calendar.current.dateComponents([.weekday], from: date).weekday
}

fileprivate func dayOfWeek(date: Date) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    return dateFormatter.string(from: date).capitalized
}

public struct IntervalComponentHandlerCache {
    public var lastDate: Date
}

public struct IntervalComponentHandlerInput: Codable {
    public init(
        intervalType: IntervalComponentHandlerInput.IntervalType,
        time: Date
    ) {
        self.intervalType = intervalType
        self.time = time
    }

    public struct WeekDay: Codable, CaseIterable {
        public let index: Int
        public let name: String
        
        public static let sat = WeekDay(index: 5, name: "Saturday")
        public static let sun = WeekDay(index: 6, name: "Sunday")
        
        public static let mon = WeekDay(index: 0, name: "Monday")
        public static let tue = WeekDay(index: 1, name: "Tuesday")
        public static let wed = WeekDay(index: 2, name: "Wednesday")
        public static let thu = WeekDay(index: 3, name: "Thursday")
        public static let fri = WeekDay(index: 4, name: "Friday")
        
        public static var allCases: [IntervalComponentHandlerInput.WeekDay] = [
            .mon, .tue, .wed, .thu, .fri, .sat, .sun
        ]
        
        public static func byIndex(_ index: Int) -> WeekDay? {
            return allCases.first { $0.index == index }
        }
        
        public static var today: WeekDay {
            return .byIndex(
                dayNumberOfWeek(date: Date()) ?? 0
            ) ?? .mon
        }
        
        public static var notToday: WeekDay {
            return .byIndex(
                (dayNumberOfWeek(date: Date()) ?? 0) + 1
            ) ?? .mon
        }
    }
    
    public enum IntervalType: Codable {
        case byWeek(WeekDays)
        
        // interval in days
        case interval(Int)
        
        case minutesInterval(Int)
        case secondsInterval(Int)
        case hoursInterval(Int)
        
    }
    
    public typealias WeekDays = [WeekDay]

    public let intervalType: IntervalType
    public let time: Date
}

public class IntervalComponentHandler: AppearComponentHandler {
    init(input: Data) {
        self.input = input
    }

    public func shouldAppear() -> Bool {
        guard let _input = getInput() else {
            return false
        }
        
        switch _input.intervalType {            
        case .secondsInterval(let interval):
            let calendar = Calendar.current
            let startDate = cache.lastDate
            let endDate = Date()

            if let seconds = getInterval(component: .second, date1: startDate, date2: endDate).second {
                if seconds >= interval {
                    self.cache.lastDate = Date() // <- [!] set state
                    return true
                }
            }

        case .hoursInterval(let interval):
            let calendar = Calendar.current
            let startDate = cache.lastDate
            let endDate = Date()

            if let hours = getInterval(component: .hour, date1: startDate, date2: endDate).second {
                if hours >= interval {
                    self.cache.lastDate = Date() // <- [!] set state
                    return true
                }
            }

        case .minutesInterval(let interval):
            let calendar = Calendar.current
            let startDate = cache.lastDate
            let endDate = Date()

            if let minutes = getInterval(component: .minute, date1: startDate, date2: endDate).second {
                if minutes >= interval {
                    self.cache.lastDate = Date() // <- [!] set state
                    return true
                }
            }
            
        default: break
        }
        return false 
    }
    
    // [!] all this variables mustn't be used outside
    public var input: Data
    public var cache: IntervalComponentHandlerCache = .init(lastDate: Date())
}

//MARK: - helpers
private extension IntervalComponentHandler {
    func getInput() -> IntervalComponentHandlerInput? {
        return try? JSONDecoder().decode(IntervalComponentHandlerInput.self, from: input)
    }
    
    func getInterval(component: Calendar.Component, date1: Date, date2: Date) -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([component], from: date1, to: date2)
        return components
    }
}

//MARK: - helpers
private extension IntervalComponentHandler {
    func substractDates(lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    func isToday(_ day: IntervalComponentHandlerInput.WeekDay) -> Bool {
        let today = Date()
        if dayNumberOfWeek(date: today) == day.index {
            return true
        }
        return false
    }
    
    func isNowTimeBigger(_ time: Date) -> Bool {
        let calendar = Calendar.current
        let newDate = Date(timeIntervalSinceReferenceDate: 0)

        let timeDateComponents = calendar.dateComponents([.hour, .minute], from: time)
        let nowDateComponets = calendar.dateComponents([.hour, .minute], from: Date())
        
        if
            let _timeDate = calendar.date(
                byAdding: timeDateComponents,
                to: newDate),
            let _nowDate = calendar.date(
                byAdding: nowDateComponets,
                to: newDate)
        {
            return _nowDate >= _timeDate
        }
        return false
    }
}
