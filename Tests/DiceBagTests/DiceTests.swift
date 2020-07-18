import XCTest

@testable
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

  func testRollingSpec() {
    let sides = 4
    let count = 2
    let modifier = 1
    let die = Die(d: sides)

    let specification = Specification(count * die, +modifier)

    var rolls: Set<Int> = []

    for _ in 1...1000 {
      rolls.insert(specification.roll())
    }

    XCTAssertEqual(rolls, [3, 4, 5, 6, 7, 8, 9], "Dice spec rolled invalid values.")
  }

  func testSpecification() {
    guard
      let specification = Specification("3d6 + 3")
    else {
      return XCTFail("Specification is nil.")
    }

    XCTAssertEqual(specification, Specification(3 * Die(d: 6), +3))
  }

}
