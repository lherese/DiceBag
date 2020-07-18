public struct Specification: Equatable {
  enum Entry: Equatable {
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

    init?(_ specification: String) {
      if let constant = Int(specification) {
        self = .constant(constant)
      } else {
        self = .die(1, die: Die(d: 6))
      }
    }
  }

  let entries: [Entry]

  public init?(_ specification: String) {
    let trimmedSpecification = specification.filter { character in
      !character.isWhitespace
    }

    self.entries = []
  }

  init(_ entries: Entry...) {
    self.entries = entries
  }

  public func roll() -> Int {
    self.entries.reduce(into: 0) { result, die in
      result += die.roll()
    }
  }
}

func * (count: Int, die: Die) -> Specification.Entry {
  .die(count, die: die)
}

prefix func + (constant: Int) -> Specification.Entry {
  .constant(constant)
}
