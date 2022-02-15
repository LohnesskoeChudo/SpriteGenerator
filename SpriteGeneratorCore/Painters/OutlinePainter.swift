//
//  Created by VasiliyKlyotskin
//

final class OutlinePainter: Painter {
    
    private let outliner: Painter
    private let painter: Painter

    init(painter: Painter, outliner: Painter) {
        self.painter = painter
        self.outliner = outliner
    }
    
    func color(for position: Position) -> Color? {
        if isOutline(position: position) {
            return outliner.color(for: position)
        } else {
            return painter.color(for: position)
        }
    }
    
    private func isOutline(position: Position) -> Bool {
        if painter.applied(to: position) { return false }
        for bodyPosition in outlineScheme(for: position) {
            if painter.applied(to: bodyPosition) { return true }
        }
        return false
    }

    private func outlineScheme(for position: Position) -> [Position] {
        [Position(x: position.x + 1, y: position.y),
         Position(x: position.x - 1, y: position.y),
         Position(x: position.x, y: position.y - 1),
         Position(x: position.x, y: position.y + 1)]
    }
}
