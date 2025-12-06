import Algorithms
import AdventUtilities
import RegexBuilder

//typealias Operator = (Int, Int) -> Int
typealias Reducer = ([Int]) -> Int

func makeReducer<S: StringProtocol>(_ opString: S) -> Reducer {
  if opString == "+" {
    { array in array.reduce(0, +) }
  } else {
    { array in array.reduce(1, *) }
  }
}

func parsePartOneInput(_ src: String) -> ([[Int]], [Reducer]) {
  let lines = src.split(separator: "\n")
  let numbers = lines.dropLast().map {
    $0.split(separator: OneOrMore(.whitespace)).compactMap(Int.init)
  }

  let reducers = lines.last!.split(separator: OneOrMore(.whitespace)).map(makeReducer)
  return (numbers, reducers)
}

public func partOne() {
  let (numbers, reducers)  = parsePartOneInput(input)

  var result = 0
  for i in 0..<numbers.numberOfColumns {
    let value = reducers[i](numbers.column(at: i))
    result += value
  }
  print(result) // 6209956042374
}

func parsePartTwoInput(_ src: String) -> [([Int], Reducer)] {
  let charsGrid = src.split(separator: "\n").map(Array.init)

  var chars = (0..<charsGrid.numberOfColumns).reduce(into: []) { result, idx in
    result.append(contentsOf: charsGrid.column(at: idx).reversed())
  }.reversed()[...]

  var result = [([Int], Reducer)]()
  while chars.notEmpty {
    let numberChars = chars.prefix { $0 != "+" && $0 != "*"}
    chars = chars.dropFirst(numberChars.count)
    let numbers = String(numberChars).split(separator: OneOrMore(.whitespace)).compactMap(Int.init)
    result.append((numbers, makeReducer(String(chars.removeFirst()))))
  }
  return result
}


public func partTwo() {
  let parsed = parsePartTwoInput(input)
  
  var result = 0
  for (numbers, reducer) in parsed {
    result += reducer(numbers)
  }  
  print(result) // 12608160008022
}
