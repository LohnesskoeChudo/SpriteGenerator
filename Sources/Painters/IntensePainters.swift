//
//  Created by VasiliyKlyotskin
//

final class IntensePainter: Painter {

    private let painter: Painter
    private let intense: Double

    init(painter: Painter, intense: Double) {
        self.painter = painter
        self.intense = intense
    }
    
    func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(saturation: intense)
    }
}


final class IntenseRatePainter: Painter {

    private let painter: Painter
    private let intenseRate: Double

    init(painter: Painter, intenseRate: Double) {
        self.painter = painter
        self.intenseRate = intenseRate
    }

    func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(saturationRate: intenseRate)
    }
}


final class RandomIntensePainter: Painter {

    private let painter: Painter
    private let intense: Double

    init(painter: Painter, intenseRange: ClosedRange<Double>) {
        self.painter = painter
        self.intense = Double.random(in: intenseRange)
    }
    
    func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(saturation: intense)
    }
}


final class RandomIntenseRatePainter: Painter {
    
    private let painter: Painter
    private let intenseRate: Double

    init(painter: Painter, intenseRateRange: ClosedRange<Double>) {
        self.painter = painter
        self.intenseRate = Double.random(in: intenseRateRange)
    }

    func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(saturationRate: intenseRate)
    }
}


final class RandomIntenseForPositionPainter: Painter {

    private let painter: Painter
    private let intenseRange: ClosedRange<Double>
    private var cache = PositionCache<Double>()

    init(painter: Painter, intenseRange: ClosedRange<Double>) {
        self.painter = painter
        self.intenseRange = intenseRange
    }

    func color(for position: Position) -> Color? {
        let intense = cache.get(with: position) { Double.random(in: intenseRange) }
        return painter.color(for: position)?.with(saturation: intense)
    }
}


final class RandomIntenseRateForPositionPainter: Painter {
    
    private let painter: Painter
    private let intenseRateRange: ClosedRange<Double>
    private var cache = PositionCache<Double>()

    init(painter: Painter, intenseRateRange: ClosedRange<Double>) {
        self.painter = painter
        self.intenseRateRange = intenseRateRange
    }

    func color(for position: Position) -> Color? {
        let intenseRate = cache.get(with: position) { Double.random(in: intenseRateRange) }
        return painter.color(for: position)?.with(saturationRate: intenseRate)
    }
}
