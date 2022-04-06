//
//  Created by VasiliyKlyotskin
//

final class OpacityPainter: Painter {

    private let painter: Painter
    private let opacity: Double

    init(painter: Painter, opacity: Double) {
        self.painter = painter
        self.opacity = opacity
    }
    
    func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(alpha: opacity)
    }
}


final class OpacityRatePainter: Painter {

    private let painter: Painter
    private let opacityRate: Double

    init(painter: Painter, opacityRate: Double) {
        self.painter = painter
        self.opacityRate = opacityRate
    }
    
    func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(alphaRate: opacityRate)
    }
}


final class RandomOpacityPainter: Painter {

    private let painter: Painter
    private let opacity: Double

    init(painter: Painter, opacityRange: ClosedRange<Double>) {
        self.painter = painter
        self.opacity = Double.random(in: opacityRange)
    }
    
    func color(for position: Position) -> Color? {
        return painter.color(for: position)?.with(alpha: opacity)
    }
}


final class RandomOpacityRatePainter: Painter {

    private let painter: Painter
    private let opacityRate: Double

    init(painter: Painter, opacityRateRange: ClosedRange<Double>) {
        self.painter = painter
        self.opacityRate = Double.random(in: opacityRateRange)
    }

    func color(for position: Position) -> Color? {
        return painter.color(for: position)?.with(alphaRate: opacityRate)
    }
}


final class RandomOpacityForPositionPainter: Painter {
    
    private let painter: Painter
    private let opacityRange: ClosedRange<Double>
    private var cache = PositionCache<Double>()

    init(painter: Painter, opacityRange: ClosedRange<Double>) {
        self.painter = painter
        self.opacityRange = opacityRange
    }

    func color(for position: Position) -> Color? {
        let opacity = cache.get(with: position) { Double.random(in: opacityRange) }
        return painter.color(for: position)?.with(alpha: opacity)
    }
}


final class RandomOpacityRateForPositionPainter: Painter {
    
    private let painter: Painter
    private let opacityRateRange: ClosedRange<Double>
    private var cache = PositionCache<Double>()

    init(painter: Painter, opacityRateRange: ClosedRange<Double>) {
        self.painter = painter
        self.opacityRateRange = opacityRateRange
    }

    func color(for position: Position) -> Color? {
        let opacityRate = cache.get(with: position) { Double.random(in: opacityRateRange) }
        return painter.color(for: position)?.with(alphaRate: opacityRate)
    }
}
