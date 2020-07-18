import XCTest

import DiceBag

final class DiceTests: XCTestCase {

  func testRolling() {
    let sides = 6
    let die = Die(d: sides)

    var rolls: Set<Int> = []

    for _ in 1...1000 {
      rolls.insert(die.roll())
    }

    XCTAssertEqual(rolls, [1, 2, 3, 4, 5, 6], "Dice rolled invalid values.")
  }

}
