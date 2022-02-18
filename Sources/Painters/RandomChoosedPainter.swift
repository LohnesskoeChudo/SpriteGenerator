//
//  Created by VasiliyKlyotskin
//

final class RandomChoosedPainter: Painter {
    
    private var choosedPainter: Painter
    var delegate: RandomChoosedTemplateDelegate?
    
    init (paintersWithProbabilities: [(Painter, Double)],
          delegate: RandomChoosedTemplateDelegate? = nil) {
        self.delegate = delegate
        let indexed = paintersWithProbabilities.enumerated()
        let sortedPainters = indexed.sorted(by: { $0.1.1 > $1.1.1 })
        let probabilitiesSum = sortedPainters.map{ $1.1 }.reduce(0, +)
        var accumulatedProbabilities = 0.0
        let randomed = Double.random(in: 0..<probabilitiesSum)
        for (index, (painter, probability)) in sortedPainters {
            accumulatedProbabilities += probability
            if randomed < accumulatedProbabilities {
                choosedPainter = painter
                delegate?.choosed(index: index, probability: probability)
                return
            }
        }
        choosedPainter = sortedPainters.last?.element.0 ?? VoidPainter()
    }
    
    func color(for position: Position) -> Color? {
        choosedPainter.color(for: position)
    }
}
