//
//  Created by VasiliyKlyotskin
//

final class BrightnessPainter: Painter {

    private let painter: Painter
    private let brightness: Double

    init(painter: Painter, brightness: Double) {
        self.painter = painter
        self.brightness = brightness
    }
    
    func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(brightness: brightness)
    }
}


final class BrightnessRatePainter: Painter {
    
    private let painter: Painter
    private let brightnessRate: Double

    init(painter: Painter, brightnessRate: Double) {
        self.painter = painter
        self.brightnessRate = brightnessRate
    }

    func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(brightnessRate: brightnessRate)
    }
}


final class RandomBrightnessPainter: Painter {
    
    private let painter: Painter
    private let brightness: Double

    init(painter: Painter, brightnessRange: ClosedRange<Double>) {
        self.painter = painter
        self.brightness = Double.random(in: brightnessRange)
    }

    func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(brightness: brightness)
    }
}


final class RandomBrightnessRatePainter: Painter {
    
    private let painter: Painter
    private let brightnessRate: Double

    init(painter: Painter, brightnessRateRange: ClosedRange<Double>) {
        self.painter = painter
        self.brightnessRate = Double.random(in: brightnessRateRange)
    }

    func color(for position: Position) -> Color? {
        painter.color(for: position)?.with(brightnessRate: brightnessRate)
    }
}


final class RandomBrightnessForPositionPainter: Painter {

    private let painter: Painter
    private let brightnessRange: ClosedRange<Double>
    private var cache = PositionCache<Double>()
    
    init(painter: Painter, brightnessRange: ClosedRange<Double>) {
        self.painter = painter
        self.brightnessRange = brightnessRange
    }
    
    func color(for position: Position) -> Color? {
        let brightness = cache.get(with: position) { Double.random(in: brightnessRange) }
        return painter.color(for: position)?.with(brightness: brightness)
    }
}


final class RandomBrightnessRateForPositionPainter: Painter {
    
    private let painter: Painter
    private let brightnessRateRange: ClosedRange<Double>
    private var cache = PositionCache<Double>()

    init(painter: Painter, brightnessRateRange: ClosedRange<Double>) {
        self.painter = painter
        self.brightnessRateRange = brightnessRateRange
    }

    func color(for position: Position) -> Color? {
        let brightnessRate = cache.get(with: position) { Double.random(in: brightnessRateRange) }
        return painter.color(for: position)?.with(brightnessRate: brightnessRate)
    }
}
