import UIKit

public class Square: Comparable {
    
    public let i: Int
    public let j: Int
    public var parent: Square? = nil
    
    public var isObstacle: Bool
    public var view: UIView
    var center: CGPoint
    
    var H = 0.0
    var G = 0.0
    
    public init(isObstacle: Bool, i: Int, j: Int, view: UIView) {
        self.isObstacle = isObstacle
        self.i = i
        self.j = j
        self.view = view
        self.center = view.center
    }
    
    var F: Double {
        return G + H
    }
    
    func neighbors(matrix: [[Square]]) -> [Square] {
        
        var neighbors = [Square]()
        
        for y in -1...1 {
            
            for x in -1...1 {
                
                if x == 0 && y == 0 { continue }
                
                let checkX = self.i + x
                let checkY = self.j + y
                
                if checkX < 0 || checkX >= matrix[0].count || checkY < 0 || checkY >= matrix.count { continue }
                
                neighbors.append(matrix[checkY][checkX])
            }
            
        }
        
        return neighbors
    }
    
    
    public func backtrace() -> [Square] {
        var trace = [Square]()
        var node = self
        
        while let parent = node.parent {
            trace.append(parent)
            node = parent
        }
        
        return trace.reversed()
        
    }
    
    public static func <(lhs: Square, rhs: Square) -> Bool {
        
        if lhs.F == rhs.F {
            return lhs.H < rhs.H
        }
        
        return lhs.F < rhs.F
    }
    
    public static func ==(lhs: Square, rhs: Square) -> Bool {
        return lhs.center == rhs.center
    }
    
}
