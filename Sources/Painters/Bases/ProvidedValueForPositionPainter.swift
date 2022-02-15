//
//  Created by VasiliyKlyotskin
//

class ProvidedValueForPositionPainter<T>: Painter {
    
    let painter: Painter
    private var cachedValues = [Position: T]()

    init(painter: Painter) {
        self.painter = painter
    }
    
    init() {
        painter = VoidPainter()
    }

    func valueFor(position: Position) -> T {
        cachedValues.value(for: position) {
            provideValue(for: position)
        }
    }
    
    func provideValue(for position: Position) -> T {
        fatalError("Implement in subclass")
    }
    
    func color(for position: Position) -> Color? {
        fatalError("Implement in subclass")
    }
}
