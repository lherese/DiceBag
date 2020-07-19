import XCTest

@testable
import DiceBag

final class DiceTests: XCTestCase {

  func testSpecification() {
    XCTAssertEqual(Specification("d6"), Specification(1 * Die(d: 6)))
    XCTAssertEqual(Specification("3d6"), Specification(3 * Die(d: 6)))
    XCTAssertEqual(Specification("3d6 + 3"), Specification(3 * Die(d: 6), +3))
    XCTAssertEqual(Specification("3d6 - 2"), Specification(3 * Die(d: 6), +(-2)))
    XCTAssertEqual(Specification("3d6 * 2"), Specification(.multiplier(3 * Die(d: 6), +2)))
  }

}
