import UIKit

public class Button: UIButton {

    weak var parent: UIView?
    let count: Int

    public init(frame: CGRect, parent: UIView, count: Int) {
        self.count = count
        self.parent = parent
        super.init(frame: frame)

        self.setTitle("Locate", for: .normal)
        self.titleLabel?.font = UIFont(name: "Menlo", size: 20)
        self.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.3254901961, blue: 0.3843137255, alpha: 1)
        
        let x = frame.origin.x
        let y = frame.origin.y + frame.height

        let shadow = UIView(frame: CGRect(x: x, y: y, width: frame.width, height: 10))
        shadow.backgroundColor = #colorLiteral(red: 0.8431372549, green: 0.2549019608, blue: 0.3058823529, alpha: 1)
        parent.addSubview(shadow)
        
        self.addTarget(self, action: #selector(pressedDown), for: .touchDown)
        self.addTarget(self, action: #selector(releasePress), for: .touchUpInside)
    }
    
    func pressedDown() {
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.byValue = 8
        animation.duration = 0.1
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        self.layer.add(animation, forKey: nil)
    }
    
    func releasePress() {
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.byValue = -8
        animation.duration = 0.1
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        self.layer.add(animation, forKey: nil)
        
        guard let parent = parent else {
            return
        }
        
        let player = parent.subviews.first { $0.tag == Tags.player && $0.hasParents(parent: parent) }
        let coin = parent.subviews.first { $0.tag == Tags.coin && $0.hasParents(parent: parent) }
        let obstacles = parent.subviews.filter { $0.tag == Tags.chest }
        
        if player == nil || coin == nil {
            return
        }

        let squares = parent.subviews.filter{ $0.tag == Tags.fields }.enumerated().map {
            (offset, element) -> Square in
            element.subviews.forEach { $0.removeFromSuperview() }
            
            let isObstacle = obstacles.map { $0.center }.contains(element.center)
            return Square(isObstacle: isObstacle, i: offset % count, j: Int(offset / count), view: element)
        }

        let start = squares.first { $0.center == player?.center }!
        let end = squares.first { $0.center == coin?.center }!

        var nodes = [[Square]].init(repeating: [Square](), count: count)
        
        for (offset, value) in squares.enumerated() {
            nodes[offset / count].append(value)
        }

        guard let destination = Algorithm.shared.aStar(start: start, goal: end, matrix: nodes) else {
            return
        }
 
        var route = destination.backtrace()

        route.forEach {
 
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            
            let attributeSmall = [NSFontAttributeName: UIFont.systemFont(ofSize: 10),
                                  NSForegroundColorAttributeName: UIColor.white]
            let attributeBig = [NSFontAttributeName: UIFont.systemFont(ofSize: 17),
                                NSForegroundColorAttributeName: UIColor.white]

            let attributedG = NSMutableAttributedString(string: "\(Int($0.G / 100)) ", attributes: attributeSmall)
            let attributedH = NSMutableAttributedString(string: "\(Int($0.H / 100))", attributes: attributeSmall)
            let attributedF = NSMutableAttributedString(string: "\(Int($0.F / 100)) ", attributes: attributeBig)
            
            attributedG.append(attributedF)
            attributedG.append(attributedH)
            
            label.attributedText = attributedG
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            
            $0.view.addSubview(label)
        }
        
        route.append(destination)
        Player(route: route.map { $0.center }, player: player!).move()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
