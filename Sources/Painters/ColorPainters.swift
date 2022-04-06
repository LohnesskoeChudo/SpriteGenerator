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


final class RandomColorForPositionPainter: Painter {

    private var cache = PositionCache<Color>()
    
    func color(for position: Position) -> Color? {
        return cache.get(with: position) { Color.randomReadable() }
    }
}
