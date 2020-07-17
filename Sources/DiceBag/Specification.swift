public struct Specification {
  enum Entry {
    case die(_ die: Die)
    case constant(_ constant: Int)
    case multiplier(_ multiplier: Int, die: Die)
  }

  let entries: [Entry]

  public init?(_ specification: String) {
    self.entries = []
  }

  public func roll() -> Int {
    1
  }
}
