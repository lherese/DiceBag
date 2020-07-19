import XCTest

import DiceBag

final class InterfaceTests: XCTestCase {

  func testRolling() {
    let die = Die(d: 6)

    var rolls: Set<Int> = []

    for _ in 1...1000 {
      rolls.insert(die.roll())
    }

    XCTAssertEqual(rolls, [1, 2, 3, 4, 5, 6], "Dice rolled invalid values.")
  }

  func testRollingSpec() {
    guard
      let specification = Specification("2d4 + 1")
    else {
      return XCTFail("Specification could not be created.")
    }

    var rolls: Set<Int> = []

    for _ in 1...1000 {
      rolls.insert(specification.roll())
    }

    XCTAssertEqual(rolls, [3, 4, 5, 6, 7, 8, 9], "Dice spec rolled invalid values.")
  }

  func testInvalidSpecification() {
    XCTAssertNil(Specification("2d3d2"), "Double dice marker in specification.")
  }

}
