import Algorithms

func makeSpins(_ str: String) -> [Int] {
  str.split(separator: "\n").map {
    let direction = $0.first == "L" ? -1 : 1
    let value = Int($0.dropFirst())!
    return direction * value
  }
}

public func partOne() {
  var value = 50
  var zeroCount = 0

  for spin in makeSpins(input) {
    value += spin % 100
    if value < 0 { value += 100 }
    if value > 99 { value -= 100 }
    if value == 0 { zeroCount += 1 }
  }
  print(zeroCount) // 1089
}

public func partTwo() {
  var value = 50
  var zeroCount = 0

  for spin in makeSpins(input) {
    let start = value
    value += spin % 100

    var rotationsThroughZero = abs(spin / 100)
    if start != 0 && value < 0 { rotationsThroughZero += 1 }
    if value > 100 { rotationsThroughZero += 1 }
    zeroCount += rotationsThroughZero

    if value < 0 { value += 100 }
    if value > 99 { value -= 100 }
    if value == 0 { zeroCount += 1 }
  }
  print(zeroCount) // 6530
}
