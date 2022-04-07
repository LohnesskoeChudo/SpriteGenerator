//
//  Created by VasiliyKlyotskin on 07.04.2022.
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
