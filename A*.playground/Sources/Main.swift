import UIKit

public class Main: UIView {

    public init() {
        let width = 50
        let height = 50
        let count = 6
        
        super.init(frame: CGRect(x: 0, y: 0, width: width * count, height: height * (count + 2) + 20))
        self.backgroundColor = .darkGray

        let button = Button(frame: CGRect(x: 10, y: 345, width: count * width - 20, height: height), parent: self, count: count)
        
        let frameCoin = CGRect(x: 10, y: 310, width: width / 2, height: height / 2)
        let frameCrate = CGRect(x: 90, y: 300, width: Double(width) / 1.3, height: Double(height) / 1.3)
        let framePlayer = CGRect(x: 190, y: 295, width: width, height: height)
        
        let coin = Dragable(frame: frameCoin, tag: Tags.coin, parent: self, image: #imageLiteral(resourceName: "coin.png"), shadow: #imageLiteral(resourceName: "coin_gray.png"), shadowTag: Tags.shadowCoin, isReproducable: false)
        let crate = Dragable(frame: frameCrate, tag: Tags.chest, parent: self, image: #imageLiteral(resourceName: "crate.png"), shadow: nil, shadowTag: nil, isReproducable: true)
        let player = Dragable(frame: framePlayer, tag: Tags.player, parent: self, image: #imageLiteral(resourceName: "player.png"), shadow: #imageLiteral(resourceName: "player_gray.png"), shadowTag: Tags.shadowPlayer, isReproducable: false)
        
        let font = UIFont(name: "Menlo", size: 15)
        
        let labelCoin = UILabel(frame: CGRect(x: frameCoin.maxX + 5, y: 312, width: 50, height: 20))
        labelCoin.text = "Coin"
        labelCoin.textColor = .white
        labelCoin.font = font
        
        let labelCrate = UILabel(frame: CGRect(x: frameCrate.maxX + 2, y: 312, width: 60, height: 20))
        labelCrate.text = "Crates"
        labelCrate.textColor = .white
        labelCrate.font = font
        
        let labelPlayer = UILabel(frame: CGRect(x: framePlayer.maxX, y: 312, width: 60, height: 20))
        labelPlayer.text = "Player"
        labelPlayer.textColor = .white
        labelPlayer.font = font
        
        Texture.shared.loadTextures(image: #imageLiteral(resourceName: "ground.png"), count: count, width: width, height: height).forEach {
            self.addSubview($0)
        }
        
        self.addSubview(coin)
        self.addSubview(crate)
        self.addSubview(player)
        self.addSubview(button)
        self.addSubview(labelCoin)
        self.addSubview(labelCrate)
        self.addSubview(labelPlayer)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
