import DiceBag

import ArgumentParser

struct Roll: ParsableCommand {
  @Argument(help: "Dice specification.")
  var dice: String

  func run() {
    guard
      let spec = Specification(dice)
    else {
      return print("Invalid dice specification: \(dice)")
    }

    print(spec.roll())
  }
}

Roll.main()
