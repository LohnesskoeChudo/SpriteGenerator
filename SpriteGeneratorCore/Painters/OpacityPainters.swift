//
//  Created by VasiliyKlyotskin
//

final class OpacityPainter: ValuePainter<Double> {
    
    override func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(alpha: value)
    }
}


final class OpacityRatePainter: ValuePainter<Double> {
    
    override func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(alphaRate: value)
    }
}


final class RandomOpacityPainter: ProvidedValuePainter<Double> {
    
    init(painter: Painter, opacityRange: ClosedRange<Double>) {
        super.init(painter: painter) { Double.random(in: opacityRange) }
    }
    
    override func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(alpha: value)
    }
}


final class RandomOpacityRatePainter: ProvidedValuePainter<Double> {
    
    init(painter: Painter, rateRange: ClosedRange<Double>) {
        super.init(painter: painter) { Double.random(in: rateRange) }
    }

    override func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(alphaRate: value)
    }
}


final class RandomOpacityForPositionPainter: ProvidedValueForPositionPainter<Double> {
    
    private let opacityRange: ClosedRange<Double>
    
    init(painter: Painter, opacityRange: ClosedRange<Double>) {
        self.opacityRange = opacityRange
        super.init(painter: painter)
    }
    
    override func provideValue(for position: Position) -> Double {
        Double.random(in: opacityRange)
    }
    
    override func color(for position: Position) -> Color? {
        let opacity = valueFor(position: position)
        return painter.color(for: position)?.with(alpha: opacity)
    }
}


final class RandomOpacityRateForPositionPainter: ProvidedValueForPositionPainter<Double> {
    
    private let rateRange: ClosedRange<Double>
    
    init(painter: Painter, rateRange: ClosedRange<Double>) {
        self.rateRange = rateRange
        super.init(painter: painter)
    }
    
    override func provideValue(for position: Position) -> Double {
        Double.random(in: rateRange)
    }

    override func color(for position: Position) -> Color? {
        let rate = valueFor(position: position)
        return painter.color(for: position)?.with(alphaRate: rate)
    }
}
