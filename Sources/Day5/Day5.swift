import Algorithms
import AdventUtilities

func parseInput(_ src: String) -> (freshRanges: [ClosedRange<Int>], ingredients: [Int]) {
  let parts = src.split(separator: "\n\n")
  let freshRanges = parts[0].split(separator: "\n").map {
    let vals = $0.split(separator: "-")
    return Int(vals[0])!...Int(vals[1])!
  }

  return (freshRanges, parts[1].split(separator: "\n").compactMap(Int.init))
}

public func partOne() {
  let (freshRanges, ingredients) = parseInput(input)
  let result = ingredients.count {
    for range in freshRanges {
      if range.contains($0) { return true }
    }
    return false
  }
  print(result)
}

public func partTwo() {
  var (freshRanges, _) = parseInput(input)
  freshRanges.sort(by: sorter(for: \.lowerBound, by: >))
  var combinedRanges = [ClosedRange<Int>]()
  while let cur = freshRanges.popLast() {
    if let prev = combinedRanges.last, cur.lowerBound <= prev.upperBound {
      guard !prev.contains(cur) else { continue }
      combinedRanges.removeLast()
      combinedRanges.append(prev.lowerBound...cur.upperBound)
    } else {
      combinedRanges.append(cur)
    }
  }

  let result = combinedRanges.map(\.count).reduce(0, +)
  print(result) // 338189277144473
}
