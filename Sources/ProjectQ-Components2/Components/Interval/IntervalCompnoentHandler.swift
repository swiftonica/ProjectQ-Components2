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

public protocol DateServiceProtocol {
    func getNowDate() -> Date
}

public class DateService: DateServiceProtocol {
    public func getNowDate() -> Date {
        return Date()
    }
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
        public let appleIndex: Int
        
        public static let sat = WeekDay(index: 5, name: "Saturday", appleIndex: 7)
        public static let sun = WeekDay(index: 6, name: "Sunday", appleIndex: 1)
        
        public static let mon = WeekDay(index: 0, name: "Monday", appleIndex: 2)
        public static let tue = WeekDay(index: 1, name: "Tuesday", appleIndex: 3)
        public static let wed = WeekDay(index: 2, name: "Wednesday", appleIndex: 4)
        public static let thu = WeekDay(index: 3, name: "Thursday", appleIndex: 5)
        public static let fri = WeekDay(index: 4, name: "Friday", appleIndex: 6)
        
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
    }
    
    public typealias WeekDays = [WeekDay]

    public let intervalType: IntervalType
    public let time: Date
}

public class IntervalComponentHandler: AppearComponentHandler {
    init(
        input: Data,
        dateService: DateServiceProtocol = DateService()
    ) {
        self.input = input
        self.dateService = dateService
        self.cache = .init(lastDate: dateService.getNowDate())
    }

    public func shouldAppear() -> Bool {
        guard let _input = getInput() else {
            return false
        }
        
        switch _input.intervalType {            
        case .interval(let interval):
            let calendar = Calendar.current
            let startDate = cache.lastDate
            let endDate = dateService.getNowDate()
            let components = calendar.dateComponents([.day], from: startDate, to: endDate)
            if let days = components.day, isNowTimeEqual(_input.time) {
                if days >= interval {
                    self.cache.lastDate = dateService.getNowDate() // <- [!] set state
                    return true
                }
            }
            
        case .byWeek(let days):
            if !days.filter({ return isToday($0) }).isEmpty, isNowTimeEqual(_input.time) {
                return true
            }
        }
        return false 
    }
    
    var dateService: DateServiceProtocol
    
    // [!] all this variables mustn't be used outside
    public var input: Data
    public var cache: IntervalComponentHandlerCache
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
public extension IntervalComponentHandler {
    func substractDates(lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    func isToday(_ day: IntervalComponentHandlerInput.WeekDay) -> Bool {
        let today = dateService.getNowDate()
        if dayNumberOfWeek(date: today) == day.appleIndex {
            return true
        }
        return false
    }
    
    func isNowTimeBigger(_ time: Date) -> Bool {
        let calendar = Calendar.current
        let newDate = Date(timeIntervalSinceReferenceDate: 0)

        let timeDateComponents = calendar.dateComponents([.hour, .minute], from: time)
        let nowDateComponets = calendar.dateComponents([.hour, .minute], from: dateService.getNowDate())
        
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
    
    func isNowTimeEqual(_ time: Date) -> Bool {
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.hour, .minute, .second], from: dateService.getNowDate())
        let components2 = calendar.dateComponents([.hour, .minute, .second], from: time)

        if components1.hour == components2.hour && components1.minute == components2.minute && components1.second == 0 {
            return true
        }
        return false
    }
    
    func dayOfWeek(date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date).capitalized
    }
}
