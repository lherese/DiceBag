public struct Die: Equatable {
  struct Roll {
    var values: [Int] = []

    var total: Int {
      values.reduce(into: 0, +=)
    }

    static func += (lhs: inout Roll, rhs: Roll) {
      lhs.values += rhs.values
    }

    static func * (lhs: Roll, rhs: Roll) -> Roll {
      let multiplier: Roll
      let entry: Roll

      if lhs.values.count == 1 {
        multiplier = lhs
        entry = rhs
      } else {
        multiplier = rhs
        entry = lhs
      }

      let values = entry
        .values
        .map {
          $0 * multiplier.total
        }

      return Roll(values: values)
    }

    mutating func keep(count: Int?) -> Roll? {
      guard
        let count = count
      else {
        return self
      }

      guard
        count < values.count
      else {
        return nil
      }

      values
        .sort(by: >)

      values = Array(values[0..<count])

      return self
    }
  }

  let sides: Int

  public init(d sides: Int) {
    self.sides = sides
  }

  func roll() -> Roll {
    Roll(values: [roll()])
  }

  public func roll() -> Int {
    Int.random(in: 1...sides)
  }

}
