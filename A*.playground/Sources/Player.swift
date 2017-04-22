import UIKit

public class Player {

    var route: [CGPoint]
    let player: UIView
    
    public init(route: [CGPoint], player: UIView) {
        self.player = player
        self.route = route.reversed()
    }

    func move() {

        let move = 0.7
        
        guard let point = route.popLast() else {
            return
        }
        
        UIView.animate(withDuration: move, animations: {
            self.player.center = point
        }, completion: { (value) in
            self.move()
        })
    }

}
