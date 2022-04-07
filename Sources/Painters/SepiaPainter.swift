//
//  Created by VasiliyKlyotskin
//

final class SepiaPainter: Painter {

    private let painter: Painter

    init(painter: Painter) {
        self.painter = painter
    }

    func color(for position: Position) -> Color? {
        painter.color(for: position)?.getSepia()
    }
}
