//
//  Created by VasiliyKlyotskin
//

final class IntensePainter: ValuePainter<Double> {
    
    override func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(saturation: value)
    }
}


final class IntenseRatePainter: ValuePainter<Double> {
    
    override func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(saturationRate: value)
    }
}


final class RandomIntensePainter: ProvidedValuePainter<Double> {
    
    init(painter: Painter, intenseRange: ClosedRange<Double>) {
        super.init(painter: painter) { Double.random(in: intenseRange) }
    }
    
    override func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(saturation: value)
    }
}


final class RandomIntenseRatePainter: ProvidedValuePainter<Double> {
    
    init(painter: Painter, rateRange: ClosedRange<Double>) {
        super.init(painter: painter) { Double.random(in: rateRange) }
    }

    override func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(saturationRate: value)
    }
}


final class RandomIntenseForPositionPainter: ProvidedValueForPositionPainter<Double> {
    
    private let intenseRange: ClosedRange<Double>

    init(painter: Painter, intenseRange: ClosedRange<Double>) {
        self.intenseRange = intenseRange
        super.init(painter: painter)
    }
    
    override func provideValue(for position: Position) -> Double {
        Double.random(in: intenseRange)
    }
    
    override func color(for position: Position) -> Color? {
        let intense = valueFor(position: position)
        return painter.color(for: position)?.with(saturation: intense)
    }
}


final class RandomIntenseRateForPositionPainter: ProvidedValueForPositionPainter<Double> {
    
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
        return painter.color(for: position)?.with(saturationRate: rate)
    }
}
