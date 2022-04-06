//
//  Created by VasiliyKlyotskin
//

final class RandomPositionPainter: Painter {

    private let painter: Painter
    private let probability: Double
    private var cache = PositionCache<Bool>()

    init(painter: Painter, probability: Double) {
        self.painter = painter
        self.probability = probability
    }
    
    func color(for position: Position) -> Color? {
        let needToPaint = cache.get(with: position) { probability > Double.random(in: 0..<1) }
        return needToPaint ? painter.color(for: position) : nil
    }
}
