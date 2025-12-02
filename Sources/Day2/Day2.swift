import Algorithms
import AdventUtilities

func makeRanges(_ src: String) -> [ClosedRange<Int>] {
  src.split(separator: ",").map {
    let values = $0.split(separator: "-").compactMap(Int.init)
    return (values[0]...values[1])
  }
}

public func partOne() {
//  var sum = 0
//  for range in makeRanges(input) {
//    for i in range {
//      let str = String(i)
//      let chunks = str.evenlyChunked(in: 2)
//      if chunks.first == chunks.second {
//        sum += i
//      }
//    }
//  }
//  print(sum) // 32976912643
}

func isInvalid(_ value: Int) -> Bool {
  let str = String(value)
  for i in 1...(str.count / 2) {
    let chunks = str.chunks(ofCount: i)
    if chunks.allSatisfy({ $0 == chunks.first }) { return true }
  }
  return false
}

public func partTwo() {
  var sum = 0
  for range in makeRanges(input) {
    for i in range where i > 9 {
      if isInvalid(i) {
        sum += i
      }
    }
  }
  print(sum)
}
