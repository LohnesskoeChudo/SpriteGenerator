//
//  Created by VasiliyKlyotskin
//

class ValuePainter<T>: Painter {
    
    let painter: Painter
    let value: T
    
    init(painter: Painter, value: T) {
        self.painter = painter
        self.value = value
    }
    
    func color(for position: Position) -> Color? {
        fatalError("Implement in subclass")
    }
    
}
