import SpriteKit

public class Dragable: UIImageView {

    weak var parent: UIView?
    var shadow: UIImage?
    var shadowTag = 1
    var isReproducable = false
    var isDragging = false
    
    public init(frame: CGRect, tag: Int, parent: UIView, image: UIImage, shadow: UIImage?, shadowTag: Int?, isReproducable: Bool) {
        super.init(frame: frame)
        
        self.tag = tag
        self.parent = parent
        self.shadow = shadow
        self.shadowTag = shadowTag ?? tag
        self.isReproducable = isReproducable
        
        let drag = UIPanGestureRecognizer(target: self, action: #selector(self.handleDrag))
        
        self.image = image
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(drag)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleDrag(_ recognizer: UIPanGestureRecognizer) {
        
        self.layer.zPosition = 1
        
        guard let parent = parent else {
            return
        }
        
        if !isDragging && isReproducable {
            parent.addSubview(Dragable(frame: self.frame, tag: tag, parent: parent, image: self.image!, shadow: nil, shadowTag: nil, isReproducable: true))
            isReproducable = false
        }
        isDragging = true
        
        let translation = recognizer.translation(in: parent)
        guard let view = recognizer.view else {
            return
        }
        
        let count = parent.subviews.filter{ $0.tag == shadowTag }.count
        if count == 0 && shadow != nil {
            let shadowView = UIImageView(frame: view.frame)
            shadowView.image = shadow
            shadowView.tag = shadowTag
            shadowView.layer.zPosition = -1
            parent.addSubview(shadowView)
        }
        
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        recognizer.setTranslation(.zero, in: parent)
        
        if recognizer.state != .ended {
            return
        }

        let p1 = view.center
        let center = parent.subviews.filter{ ($0.tag == Tags.fields || $0.tag == shadowTag) && $0 != self && !$0.hasChilds(parent: parent) }.min {
            (view1: UIView, view2: UIView) -> Bool in

            var p2 = view1.center
            let value1 = hypot(p1.x - p2.x, p1.y - p2.y)
         
            p2 = view2.center
            let value2 = hypot(p1.x - p2.x, p1.y - p2.y)
        
            return value1 < value2
        
        }
        
        if let center = center {
            self.layer.zPosition = 0
            self.center = center.center
            
            if self.tag == Tags.chest && center.tag == Tags.chest {
                self.removeFromSuperview()
            }
        }
        
        isDragging = false
        
    }
    
}
