//
//  Created by VasiliyKlyotskin
//

class ProvidedValuePainter<T>: Painter {
    
    let painter: Painter
    let value: T

    init(painter: Painter, valueProvider: () -> T) {
        self.painter = painter
        value = valueProvider()
    }

    func color(for position: Position) -> Color? {
        fatalError("Implement in subclass")
    }
}
