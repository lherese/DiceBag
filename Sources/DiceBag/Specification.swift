public struct Specification {
  enum Entry {
    case die(_ count: Int, die: Die)
    case constant(_ constant: Int)

    func roll() -> Int {
      switch self {
      case let .die(count, die):
        var result = 0

        for _ in 1...count {
          result += die.roll()
        }

        return result
      case let .constant(constant):
        return constant
      }
    }
  }

  let entries: [Entry]

  public init?(_ specification: String) {
    self.entries = []
  }

  public func roll() -> Int {
    self.entries.reduce(into: 0) { result, die in
      result += die.roll()
    }
  }
}
