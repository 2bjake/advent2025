import Algorithms

public func partOne() {
  partOneAndTwo()
}

public func partTwo() {

}


func findIndexOfFirstLargest(in values: ArraySlice<String>) -> Int {
  values.indices.reduce(values.startIndex) { bestIdx, idx in
    values[idx] > values[bestIdx] ? idx : bestIdx
  }
}

func findMaxJoltage(in values: ArraySlice<String>, count: Int) -> Int {
  var result = [String]()
  var startIdx = values.startIndex

  for i in (0..<count).reversed() {
    let largestIdx = findIndexOfFirstLargest(in: values[startIdx...].dropLast(i))
    startIdx = largestIdx + 1
    result.append(values[largestIdx])
  }

  return Int(result.joined())!
}

func solve(_ inputStr: String, count: Int) -> Int {
  inputStr.split(separator: "\n").map {
    let slice = Array($0).map(String.init)[...]
    return findMaxJoltage(in: slice, count: count)
  }.reduce(0, +)
}

func partOneAndTwo() {
  print(solve(input, count: 2)) // 16993
  print(solve(input, count: 12)) // 168617068915447
}
