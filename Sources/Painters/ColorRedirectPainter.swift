//
//  Created by VasiliyKlyotskin
//

final class ColorRedirectPainter: Painter {
    
    private let sourcePainter: Painter
    private let targetPainter: Painter
    
    init(source: Painter, target: Painter) {
        sourcePainter = source
        targetPainter = target
    }
    
    func color(for position: Position) -> Color? {
        if sourcePainter.applied(to: position) {
            return targetPainter.color(for: position)
        }
        return nil
    }
}
