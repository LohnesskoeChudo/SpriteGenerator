//
//  Created by VasiliyKlyotskin
//

final class ColorPainter: Painter {
    
    private let color: Color
    
    init(color: Color) { self.color = color }
    
    func color(for position: Position) -> Color? { color }
}


final class RandomColorPainter: Painter {
    
    private let color: Color
    
    init() { color = Color.randomReadable() }
    
    func color(for position: Position) -> Color? { color }
}


final class RandomColorForPositionPainter: ProvidedValueForPositionPainter<Color> {
    
    override func provideValue(for position: Position) -> Color {
        Color.randomReadable()
    }
    
    override func color(for position: Position) -> Color? {
        valueFor(position: position)
    }
}
