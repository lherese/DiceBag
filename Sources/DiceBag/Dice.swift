public struct Die: Equatable {

  let sides: Int

  public init(d sides: Int) {
    self.sides = sides
  }

  public func roll() -> Int {
    Int.random(in: 1...sides)
  }

}
