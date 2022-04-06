//
//  Created by VasiliyKlyotskin
//

public class Template {
    var painter: Painter
    
    init(_ painter: Painter) {
        self.painter = painter
    }
}

public func colorDelegate(_ delegate: ColorDelegate, _ wrapie: Template) -> Template {
    Template(ColorDelegatePainter(painter: wrapie.painter, delegate: delegate))
}

public func color(_ color: Color) -> Template {
    Template(ColorPainter(color: color))
}

public func randomColor() -> Template {
    Template(RandomColorPainter())
}

public func randomColorForPosition() -> Template {
    Template(RandomColorForPositionPainter())
}

public func composed(wrapies: [Template]) -> Template {
    Template(ComposedPainter(painters: wrapies.map { $0.painter }))
}

public func filter(positions: Set<Position>, _ wrapee: Template) -> Template {
    Template(FilterPainter(painter: wrapee.painter, suitablePositions: positions))
}

public func outline(outliner: Template, _ wrapee: Template) -> Template {
    Template(OutlinePainter(painter: wrapee.painter, outliner: outliner.painter))
}

public func verticalMirror(offset: Int, _ wrapee: Template) -> Template {
    Template(MirrorPainter(painter: wrapee.painter, offset: offset, vertical: true))
}

public func horizontalMirror(offset: Int, _ wrapee: Template) -> Template {
    Template(MirrorPainter(painter: wrapee.painter, offset: offset, vertical: false))
}

public func void() -> Template {
    Template(VoidPainter())
}

public func randomPosition(probability: Double, _ wrapee: Template) -> Template {
    Template(RandomPositionPainter(painter: wrapee.painter, probability: probability))
}

public func opacity(_ opacity: Double, _ wrapee: Template) -> Template {
    Template(OpacityPainter(painter: wrapee.painter, opacity: opacity))
}

public func opacity(rate: Double, _ wrapee: Template) -> Template {
    Template(OpacityRatePainter(painter: wrapee.painter, opacityRate: rate))
}

public func randomOpacity(range: ClosedRange<Double>, _ wrapee: Template) -> Template {
    Template(RandomOpacityPainter(painter: wrapee.painter, opacityRange: range))
}

public func randomOpacity(rateRange: ClosedRange<Double>, _ wrapee: Template) -> Template {
    Template(RandomOpacityRatePainter(painter: wrapee.painter, opacityRateRange: rateRange))
}

public func randomOpacityForPosition(range: ClosedRange<Double>, _ wrapee: Template) -> Template {
    Template(RandomOpacityForPositionPainter(painter: wrapee.painter, opacityRange: range))
}

public func randomOpacityForPosition(rateRange: ClosedRange<Double>, _ wrapee: Template) -> Template {
    Template(RandomOpacityRateForPositionPainter(painter: wrapee.painter, opacityRateRange: rateRange))
}

public func brightness(_ brightness: Double, _ wrapee: Template) -> Template {
    Template(BrightnessPainter(painter: wrapee.painter, brightness: brightness))
}

public func brightness(rate: Double, _ wrapee: Template) -> Template {
    Template(BrightnessRatePainter(painter: wrapee.painter, brightnessRate: rate))
}

public func randomBrightness(range: ClosedRange<Double>, _ wrapee: Template) -> Template {
    Template(RandomBrightnessPainter(painter: wrapee.painter, brightnessRange: range))
}

public func randomBrightness(rateRange: ClosedRange<Double>, _ wrapee: Template) -> Template {
    Template(RandomBrightnessRatePainter(painter: wrapee.painter, brightnessRateRange: rateRange))
}

public func randomBrightnessForPosition(range: ClosedRange<Double>, _ wrapee: Template) -> Template {
    Template(RandomBrightnessForPositionPainter(painter: wrapee.painter, brightnessRange: range))
}

public func randomBrightnessForPosition(rateRange: ClosedRange<Double>, _ wrapee: Template) -> Template {
    Template(RandomBrightnessRateForPositionPainter(painter: wrapee.painter, brightnessRateRange: rateRange))
}

public func intense(_ intense: Double, _ wrapee: Template) -> Template {
    Template(IntensePainter(painter: wrapee.painter, intense: intense))
}

public func intense(rate: Double, _ wrapee: Template) -> Template {
    Template(IntenseRatePainter(painter: wrapee.painter, intenseRate: rate))
}

public func randomIntense(range: ClosedRange<Double>, _ wrapee: Template) -> Template {
    Template(RandomIntensePainter(painter: wrapee.painter, intenseRange: range))
}

public func randomIntense(rateRange: ClosedRange<Double>, _ wrapee: Template) -> Template {
    Template(RandomIntenseRatePainter(painter: wrapee.painter, intenseRateRange: rateRange))
}

public func randomIntenseForPosition(range: ClosedRange<Double>, _ wrapee: Template) -> Template {
    Template(RandomIntenseForPositionPainter(painter: wrapee.painter, intenseRange: range))
}

public func randomIntenseForPosition(rateRange: ClosedRange<Double>, _ wrapee: Template) -> Template {
    Template(RandomIntenseRateForPositionPainter(painter: wrapee.painter, intenseRateRange: rateRange))
}

public func randomChoosed(_ wrapies: [(Template, probability: Double)], delegate: RandomChosenTemplateDelegate? = nil) -> Template {
    Template(RandomChosenPainter(paintersWithProbabilities: wrapies.map { ($0.0.painter, $0.probability) }, delegate: delegate))
}
             
public func linearGradient(startPoint: Point, endPoint: Point, keyPoints: [(Template, relativeOffset: Double)]) -> Template {
    let keyPoints = keyPoints.map { ($0.0.painter, $0.relativeOffset) }
    return Template(LinearGradientPainter(keyPoints: keyPoints, startPoint: startPoint, endPoint: endPoint))
}

public func colorRedirect(from source: Template, to target: Template) -> Template {
    Template(ColorRedirectPainter(source: source.painter, target: target.painter))
}
