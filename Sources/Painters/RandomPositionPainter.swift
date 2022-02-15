//
//  Created by VasiliyKlyotskin
//

final class RandomPositionPainter: ProvidedValueForPositionPainter<Bool> {
    
    private let probability: Double

    init(painter: Painter, probability: Double) {
        self.probability = probability
        super.init(painter: painter)
    }
    
    override func provideValue(for position: Position) -> Bool {
        probability > Double.random(in: 0..<1)
    }
    
    override func color(for position: Position) -> Color? {
        if valueFor(position: position) {
            return painter.color(for: position)
        }
        return nil
    }
}
