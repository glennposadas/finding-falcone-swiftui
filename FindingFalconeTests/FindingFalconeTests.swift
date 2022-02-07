import XCTest
@testable import FindingFalcone

class FindingFalconeTests: XCTestCase {
  func testAppConstants() throws {
    XCTAssertEqual(AppConstants.REQUIRED_PLANETS_COUNT_FOR_SEARCH, 4)
  }
}
