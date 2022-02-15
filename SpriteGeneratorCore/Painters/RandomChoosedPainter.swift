//
//  Created by VasiliyKlyotskin
//

final class RandomChoosedPainter: Painter {
    
    private var choosedPainter: Painter

    init (paintersWithProbabilities: [(Painter, Double)]) {
        let sortedPainters = paintersWithProbabilities.sorted(by: { $0.1 > $1.1 })
        let probabilitiesSum = sortedPainters.map{ $1 }.reduce(0, +)
        var accumulatedProbabilities = 0.0
        let randomed = Double.random(in: 0..<probabilitiesSum)
        for (painter, probability) in sortedPainters {
            accumulatedProbabilities += probability
            if randomed < accumulatedProbabilities {
                choosedPainter = painter
                return
            }
        }
        choosedPainter = sortedPainters.last?.0 ?? VoidPainter()
    }
    
    func color(for position: Position) -> Color? {
        choosedPainter.color(for: position)
    }
}
