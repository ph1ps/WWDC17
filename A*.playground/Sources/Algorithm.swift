import UIKit

public class Algorithm {
    
    public static let shared = Algorithm()
    
    public var weightDiagonally = 14.0
    public var weightHorizontally = 10.0
    
    func distance(nodeA: CGPoint, nodeB: CGPoint) -> Double {
        
        let distX = Double(abs(nodeA.x - nodeB.x))
        let distY = Double(abs(nodeA.y - nodeB.y))
        
        if distX > distY {
            return weightDiagonally * distY + weightHorizontally * (distX - distY)
        }
        
        return weightDiagonally * distX + weightHorizontally * (distY - distX)
    }
    
    public func aStar(start: Square, goal: Square, matrix: [[Square]]) -> Square? {
        
        var open = [Square]()
        var closed = [Square]()
        
        open.append(start)
        
        while !open.isEmpty {
            
            guard let current = open.min() else {
                continue
            }
            
            open = open.filter { $0 != current } //Removes item
            closed.append(current)
            
            if current == goal { //Route found
                return current
            }
            
            for neighbor in current.neighbors(matrix: matrix) {
                if neighbor.isObstacle || closed.contains(neighbor) { continue }
                
                let newPath = current.G + distance(nodeA: current.center, nodeB: neighbor.center)
                
                if open.contains(neighbor) && newPath >= neighbor.G { continue }
                
                neighbor.G = newPath
                neighbor.H = distance(nodeA: neighbor.center, nodeB: goal.center)
                
                neighbor.parent = current
                
                if !open.contains(neighbor) { open.append(neighbor) }
            }
            
        }
        
        return nil
        
    }
}
