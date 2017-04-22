import UIKit

public extension UIView {

    func hasChilds(parent: UIView) -> Bool {
        return parent.subviews.filter { $0 != self && $0.center == self.center }.count > 0
    }
    
    func hasParents(parent: UIView) -> Bool {
        return parent.subviews.filter {
            $0 != self && $0.center == self.center && $0.tag == Tags.fields
        }.count > 0
    }
}
