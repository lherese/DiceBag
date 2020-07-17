import XCTest

import DiceBag

final class DiceTests: XCTestCase {

  func testRolling() {
    let sides = 6
    let die = Die(d: sides)

    var tooHigh = false
    var tooLow = false

    for _ in 1...1000 {
      let roll = die.roll()

      if roll > sides {
        tooHigh = true
        break
      }

      if roll < 1 {
        tooLow = true
        break
      }
    }

    XCTAssertFalse(tooHigh, "Dice rolled too high.")
    XCTAssertFalse(tooLow, "Dice rolled too low.")
  }

}
