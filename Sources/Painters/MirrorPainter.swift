//
//  Created by VasiliyKlyotskin
//

final class MirrorPainter: Painter {
    
    private let painter: Painter
    private let transformToInitial: (Position) -> Position
    
    init(painter: Painter, offset: Int, vertical: Bool) {
        self.painter = painter
        if vertical {
            transformToInitial = { position in Position(x: offset - position.x - 1, y: position.y) }
        } else {
            transformToInitial = { position in Position(x: position.x, y: offset - position.y - 1) }
        }
    }
    
    func color(for position: Position) -> Color? {
        if let color = painter.color(for: position) {
            return color
        } else {
            return painter.color(for: transformToInitial(position))
        }
    }
}
