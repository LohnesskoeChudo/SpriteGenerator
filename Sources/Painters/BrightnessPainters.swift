//
//  Created by VasiliyKlyotskin
//

final class BrightnessPainter: ValuePainter<Double> {
    
    override func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(brightness: value)
    }
}


final class BrightnessRatePainter: ValuePainter<Double> {
    
    override func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(brightnessRate: value)
    }
}


final class RandomBrightnessPainter: ProvidedValuePainter<Double> {
    
    init(painter: Painter, brightnessRange: ClosedRange<Double>) {
        super.init(painter: painter) { Double.random(in: brightnessRange) }
    }
    
    override func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(brightness: value)
    }
}


final class RandomBrightnessRatePainter: ProvidedValuePainter<Double> {
    
    init(painter: Painter, rateRange: ClosedRange<Double>) {
        super.init(painter: painter) { Double.random(in: rateRange) }
    }

    override func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(brightnessRate: value)
    }
}


final class RandomBrightnessForPositionPainter: ProvidedValueForPositionPainter<Double> {
    
    private let brightnessRange: ClosedRange<Double>
    
    init(painter: Painter, brightnessRange: ClosedRange<Double>) {
        self.brightnessRange = brightnessRange
        super.init(painter: painter)
    }
    
    override func provideValue(for position: Position) -> Double {
        Double.random(in: brightnessRange)
    }
    
    override func color(for position: Position) -> Color? {
        let brightness = valueFor(position: position)
        return painter.color(for: position)?.with(brightness: brightness)
    }
}


final class RandomBrightnessRateForPositionPainter: ProvidedValueForPositionPainter<Double> {
    
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
        return painter.color(for: position)?.with(brightnessRate: rate)
    }
}
