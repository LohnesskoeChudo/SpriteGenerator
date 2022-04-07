//
//  Created by VasiliyKlyotskin on 06.04.2022.
//

protocol FunctionResultChecker {
    func isIncluded(functionResult: Point, position: Position) -> Bool
}

final class FunctionPainter: Painter {

    private let painter: Painter
    private let checker: FunctionResultChecker
    private let function: (Int) -> Double
    private var functionResultCache = PositionCache<Double>()
    private var resultIncludedCache = PositionCache<Bool>()

    init(painter: Painter,
         checker: FunctionResultChecker,
         function: @escaping (Int) -> Double) {
        self.painter = painter
        self.checker = checker
        self.function = function
    }

    func color(for position: Position) -> Color? {
        let resultIsIncluded = resultIncludedCache.get(with: position) {
            let functionResult = functionResultCache.get(with: position) { function(position.x) }
            let functionResultPoint = Point(x: Double(position.x), y: functionResult)
            return checker.isIncluded(functionResult: functionResultPoint, position: position)
        }
        return resultIsIncluded ? painter.color(for: position) : nil
    }
}
