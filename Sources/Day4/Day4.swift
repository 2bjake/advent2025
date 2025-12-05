import Algorithms
import AdventUtilities

func accessibleRollPositions(in grid: [[Character]]) -> [Position] {
  grid.allPositions.lazy
    .filter { grid[$0] == "@" }
    .filter { grid.adjacentElements(of: $0, includingDiagonals: true).filter { $0 == "@"}.count < 4 }
}

public func partOne() {
  let grid = input.split(separator: "\n").map(Array.init)
  print(accessibleRollPositions(in: grid).count) // 1602
}

public func partTwo() {
  var grid = input.split(separator: "\n").map(Array.init)
  var positions = [Position]()
  var count = 0
  repeat {
    positions = accessibleRollPositions(in: grid)
    count += positions.count
    for position in positions {
      grid[position] = "."
    }

  } while positions.notEmpty

  print(count)
}
