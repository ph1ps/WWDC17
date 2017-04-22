import SpriteKit

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

public class Texture {
    
    public static let shared = Texture()
    
    func floorInt(_ value: Double) -> Int {
        return Int(floor(value))
    }
    
    public func loadTextures(image: UIImage, count: Int, width: Int, height: Int) -> [UIView] {

        var nodes = [UIView]()
        
        let size = CGSize(width: width - 1, height: height - 1)
        for value in 0..<count ^^ 2 {
            
            let x = (value % count) * width
            let y = floorInt(Double(value / count)) * height
            let point = CGPoint(x: x, y: y)
            
            let view = UIImageView(frame: CGRect(origin: point, size: size))
            view.image = image
            view.tag = Tags.fields
            
            nodes.append(view)
        }
    
        return nodes
        
    }

}
