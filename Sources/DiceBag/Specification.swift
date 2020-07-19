import Foundation

public struct Specification: Equatable {
  indirect enum Entry: Equatable {
    case die(_ count: Int, die: Die)
    case constant(_ constant: Int)
    case multiplier(_ multiplier: Entry, _ entry: Entry)

    func roll() -> Die.Roll {
      switch self {
      case let .die(count, die):
        var result = Die.Roll()

        for _ in 1...count {
          result += die.roll()
        }

        return result
      case let .constant(constant):
        return Die.Roll(values: [constant])
      case let .multiplier(multiplier, entry):
        return entry.roll() * multiplier.roll()
      }
    }

    func roll() -> Int {
      roll().total
    }

    init?(_ specification: Substring) {
      self.init(String(specification))
    }

    init?(_ specification: String) {
      if let constant = Int(specification) {
        self = .constant(constant)
      } else if specification.contains("*") {
        let elements = specification
          .split(separator: "*", maxSplits: 1)

        guard
          let entry = Entry(elements.first!),
          let multiplier = Entry(elements.last!)
        else {
          return nil
        }

        self = .multiplier(entry, multiplier)
      } else if specification.contains("d") {
        let elements = specification
          .split(separator: "d", maxSplits: 1, omittingEmptySubsequences: false)

        guard
          let count = (elements.first! == "" ? 1 : Int(elements.first!)),
          let die = Int(elements.last!)
        else {
          return nil
        }

        self = .die(count, die: Die(d: die))
      } else {
        return nil
      }
    }
  }

  let entries: [Entry]

  public init?(_ specification: Substring) {
    self.init(String(specification))
  }

  public init?(_ specification: String) {
    let entries = specification
      .filter { !$0.isWhitespace }
      .replacingOccurrences(of: "-", with: "+-")
      .split(separator: "+")
      .map { Entry($0) }

    guard
      entries.allSatisfy({ $0 != nil })
    else {
      return nil
    }

    self.init(entries: entries.compactMap({ $0 }))
  }

  init(entries: [Entry]) {
    self.entries = entries
  }

  init(_ entries: Entry...) {
    self.init(entries: entries)
  }

  func roll() -> Die.Roll {
    self
      .entries
      .reduce(into: Die.Roll()) { result, entry in
        result += entry.roll()
      }
  }

  public func roll() -> Int {
    roll().total
  }
}

func * (count: Int, die: Die) -> Specification.Entry {
  .die(count, die: die)
}

prefix func + (constant: Int) -> Specification.Entry {
  .constant(constant)
}
