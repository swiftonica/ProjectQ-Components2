import XCTest
@testable import ProjectQ_Components2

class MockNowDateService: DateService {
    init(date: Date) {
        self.date = date
    }
    
    private let date: Date
    
    override func getNowDate() -> Date {
        return date
    }
}

final class ProjectQ_Components2Tests: XCTestCase {
    func testIsToday() throws {
        var dateComponents = [
            DateComponents(year: 2023, month: 4, day: 24, hour: 12, minute: 0, second: 0), // mon
            DateComponents(year: 2023, month: 4, day: 25, hour: 12, minute: 0, second: 0), // thu
            DateComponents(year: 2023, month: 4, day: 26, hour: 12, minute: 0, second: 0), // wen
            DateComponents(year: 2023, month: 4, day: 27, hour: 12, minute: 0, second: 0), // thir
            DateComponents(year: 2023, month: 4, day: 28, hour: 12, minute: 0, second: 0), // fri
            DateComponents(year: 2023, month: 4, day: 29, hour: 12, minute: 0, second: 0), // sat
            DateComponents(year: 2023, month: 4, day: 30, hour: 12, minute: 0, second: 0)  // sun
        ]
        
        var dates = dateComponents.compactMap {
            let calendar = Calendar.current
            return calendar.date(from: $0)
        }
        
        var allOrderedDays = IntervalComponentHandlerInput.WeekDay.allCases
        var rightCases: [Date] = []
        
        for i in 0 ..< 7 {
            let date = dates[i]
            let day = allOrderedDays[i]
            let mock = MockNowDateService(date: date)
            let input = IntervalComponentHandlerInput(intervalType: .byWeek([day]), time: date)
            let handler = IntervalComponentHandler(
                input: try! JSONEncoder().encode(input),
                dateService: mock
            )
            if handler.isToday(day) {
                rightCases.append(date)
            }
        }
    
        XCTAssertTrue(rightCases.count == 7)
    }
    
    func testInNowTimeBigger() {
        let nowTimeComp = DateComponents(year: 2023, month: 4, day: 24, hour: 12, minute: 0, second: 0)
        let testTimeComp = DateComponents(year: 2023, month: 4, day: 24, hour: 12, minute: 30, second: 0)
        let calendar = Calendar.current
        
        let nowTime = calendar.date(from: nowTimeComp)!
        let testTime = calendar.date(from: testTimeComp)!
        
        let mock = MockNowDateService(date: nowTime)
        let input = IntervalComponentHandlerInput(intervalType: .byWeek([.sat]), time: nowTime)
        let handler = IntervalComponentHandler(
            input: try! JSONEncoder().encode(input),
            dateService: mock
        )
        
        // nowTime is smaller on 30 minutes than test time. So should return false
        XCTAssertFalse(handler.isNowTimeBigger(testTime))
    }
    
    func testTwoDaysAWeekTimeBigger() {
        let calendar = Calendar.current
        
        // nowTime should be sat and has time at least on 1 second bigger than test time.
        let nowTimeComp = DateComponents(year: 2023, month: 4, day: 24, hour: 12, minute: 0, second: 1) // mon
        let testTimeComp = DateComponents(year: 2023, month: 4, day: 24, hour: 12, minute: 0, second: 0)
        
        let nowTime = calendar.date(from: nowTimeComp)!
        let testTime = calendar.date(from: testTimeComp)!
        
        let mock = MockNowDateService(date: nowTime)
        let input = IntervalComponentHandlerInput(intervalType: .byWeek([.mon]), time: testTime)
        let handler = IntervalComponentHandler(
            input: try! JSONEncoder().encode(input),
            dateService: mock
        )
        
        // nowTime accept all requirements so it should return true 
        XCTAssertTrue(handler.shouldAppear())
    }
}
