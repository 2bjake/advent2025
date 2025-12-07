import Algorithms
import AdventUtilities

func parseInput(_ src: String) -> [[Character]] {
  src.split(separator: "\n").map(Array.init)
}

public func partOne() {
  let grid = parseInput(input)
  var frontier = [Position(0, grid[0].firstIndex(of: "S")!)]
  var visited = Set<Position>()
  var count = 0
  while let cur = frontier.popLast() {
    guard grid.isValidPosition(cur) && cur.notIn(visited) else { continue }
    if grid[cur] == "^" {
      count += 1
      frontier.append(contentsOf: [cur.moved(.left), cur.moved(.right)])
    } else {
      frontier.append(cur.moved(.down))
    }
    visited.insert(cur)
  }
  print(count) // 1656
}

public func partTwo() {
  let grid = parseInput(input)
  let start = Position(0, grid[0].firstIndex(of: "S")!)
  var pathCounts: [[Int?]] = Array(repeating: Array(repeating: nil, count: grid.numberOfColumns), count: grid.numberOfRows)
  
  func pathsFrom(_ pos: Position) -> Int {
    guard grid.isValidPosition(pos) else { return 1 }
    if let count = pathCounts[pos] { return count }
    
    let count: Int
    if grid[pos] == "^" {
      count = pathsFrom(pos.moved(.left).moved(.down)) + pathsFrom(pos.moved(.right).moved(.down))
    } else {
      count = pathsFrom(pos.moved(.down))
    }
    pathCounts[pos] = count
    return count
  }
  
  for col in (0..<grid.numberOfColumns).reversed() where col.isMultiple(of: 2) {
    for pos in grid.positionsInColumn(col) {
      _ = pathsFrom(pos) // load up pathCounts
    }
  }
  
  print(pathsFrom(start)) // 76624086587804
}
