//
//  Created by VasiliyKlyotskin
//

import UIKit
import SpriteGenerator

class ViewController: UIViewController {
    
    private let exampleDataSource = ExampleDataSource()
    private let pixelSizeInPoints = 10
    private var sprite = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildSprite()
        setupGenerateButton()
    }
    
    private func buildSprite() {
        sprite.removeFromSuperview()
        sprite = UIView()
        sprite.backgroundColor = .orange.withAlphaComponent(0.05)
        view.addSubview(sprite)
        exampleDataSource.generateColors()
        buildPixels()
        sprite.frame = CGRect(origin: .zero, size: CGSize(width: exampleDataSource.width * pixelSizeInPoints, height: exampleDataSource.height * pixelSizeInPoints))
        sprite.center = view.center
    }
    
    private func setupGenerateButton() {
        let button = UIButton()
        view.addSubview(button)
        button.setTitle("Generate", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(generateButtonTapped), for: .touchUpInside)
        button.frame = CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: view.frame.width, height: 50))
    }
    
    @objc private func generateButtonTapped() {
        buildSprite()
    }

    private func buildPixels() {
        for position in exampleDataSource.colorOutput.positions {
            setPixelView(for: position)
        }
    }
    
    private func setPixelView(for position: Position) {
        let pixelView = UIView()
        sprite.addSubview(pixelView)
        pixelView.backgroundColor = uiColor(for: exampleDataSource.colorOutput[position])
        pixelView.frame = CGRect(origin: pixelOriginFor(position: position), size: CGSize(width: pixelSizeInPoints, height: pixelSizeInPoints))
    }
    
    private func pixelOriginFor(position: Position) -> CGPoint {
        CGPoint(x: position.x * pixelSizeInPoints, y: position.y * pixelSizeInPoints)
    }

    private func uiColor(for color: Color?) -> UIColor {
        guard let color = color else { return .clear }
        let ((r, g, b), a) = (color.getRgb(), color.alpha)
        return UIColor(red: round(r*256)/256, green: round(g*256)/256, blue: round(b*256)/256, alpha: a)
    }
}
