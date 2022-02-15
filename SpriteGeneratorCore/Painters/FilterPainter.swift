//
//  Created by VasiliyKlyotskin
//

final class FilterPainter: Painter {

    private let suitablePositions: Set<Position>
    private let painter: Painter
    
    init(painter: Painter, suitablePositions: Set<Position>) {
        self.painter = painter
        self.suitablePositions = suitablePositions
    }
   
    func color(for position: Position) -> Color? {
        if suitablePositions.contains(position) {
            return painter.color(for: position)
        }
        return nil
    }
}
