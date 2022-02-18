//
//  Created by VasiliyKlyotskin
//

final class ColorDelegatePainter: Painter {
    
    private let delegate: ColorDelegate
    private let painter: Painter
    
    init(painter: Painter, delegate: ColorDelegate) {
        self.painter = painter
        self.delegate = delegate
    }
    
    func color(for position: Position) -> Color? {
        let color = painter.color(for: position)
        delegate.provided(color: color, for: position)
        return color
    }
}
