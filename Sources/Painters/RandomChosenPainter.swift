//
//  Created by VasiliyKlyotskin
//

final class RandomChosenPainter: Painter {
    
    private var chosenPainter: Painter?
    private var delegate: RandomChoosedTemplateDelegate?
    
    init (paintersWithProbabilities: [(Painter, Double)],
          delegate: RandomChoosedTemplateDelegate? = nil) {
        self.delegate = delegate
        chosenPainter = randomChosenPainter(in: paintersWithProbabilities)
    }
    
    func color(for position: Position) -> Color? {
        chosenPainter?.color(for: position)
    }

    private func randomChosenPainter(in paintersWithProbabilities: [(Painter, Double)]) -> Painter? {
        let indexed = paintersWithProbabilities.enumerated()
        let sortedPainters = indexed.sorted(by: { $0.1.1 > $1.1.1 })
        let probabilitiesSum = sortedPainters.map{ $1.1 }.reduce(0, +)
        var accumulatedProbabilities = 0.0
        let randomed = Double.random(in: 0..<probabilitiesSum)
        for (index, (painter, probability)) in sortedPainters {
            accumulatedProbabilities += probability
            if randomed < accumulatedProbabilities {
                delegate?.chosen(index: index, probability: probability)
                return painter
            }
        }
        return nil
    }
}
