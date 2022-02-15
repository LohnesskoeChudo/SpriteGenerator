//
//  Created by VasiliyKlyotskin
//

final class ComposedPainter: Painter {
    
    private let painters: [Painter]
    
    init(painters: [Painter]) {
        self.painters = painters
    }
    
    func color(for position: Position) -> Color? {
        for painter in painters {
            if let color = painter.color(for: position) {
                return color
            }
        }
        return nil
    }
}
