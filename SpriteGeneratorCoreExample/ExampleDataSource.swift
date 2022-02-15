//
//  Created by VasiliyKlyotskin
//

import SpriteGeneratorCore
import UIKit

final class ExampleDataSource {
    
    var colorOutput = Table<Color>()
    var width = 14
    var height = 14
    
    private let scheme = Table(values:
    [[0,0,0,0,0,0,0],
     [0,0,0,0,0,5,5],
     [0,0,0,0,5,1,1],
     [0,0,0,0,5,1,2],
     [0,0,0,5,1,1,2],
     [0,0,0,5,1,1,2],
     [0,0,5,1,1,1,2],
     [0,5,1,1,1,3,4],
     [0,5,1,1,1,3,4],
     [0,5,1,1,1,3,4],
     [0,5,1,1,1,1,2],
     [0,0,5,5,1,1,1],
     [0,0,0,0,5,5,5],
     [0,0,0,0,0,0,0]])!

    func generateColors() {
        colorOutput = Table(xSize: width, ySize: height, value: Color())
        let generator = SpriteGenerator(colorOutput: colorOutput)
        let template = makeTemplate()
        generator.generate(from: template)
    }
    
    typealias Scheme = Table<Int>
    typealias T = Template

    private func makeTemplate() -> Template {
        composed(wrapies: [
            verticalMirror(offset: 14,
            makeSkeleton()),
            
            randomOpacityForPosition(rateRange: 0.5...1,
            verticalMirror(offset: 14,
            makeCockpit())),
            
            makeBody(),
            
            linearGradient(startPoint: Point(x: 0, y: 0), endPoint: Point(x: 17, y: 17), keyPoints: [
                (randomOpacityForPosition(rateRange: 0.1...0.4, randomColor()), 0),
                (randomColor(), 1)
            ])
        ])
    }
 
    private func makeBody() -> Template {
        outline(outliner: color(.black),
        verticalMirror(offset: 14,
        filter(positions: Set(scheme.positionsFor(value: 1)),
        randomPosition(probability: 0.5,
        linearGradient(startPoint: Point(x: 0, y: 13), endPoint: Point(x: 13, y: 0), keyPoints: [
           (randomColor(), 0.25),
           (randomColor(), 0.5),
           (randomColor(), 0.75)
        ])))))
    }
    
    private func makeCockpit() -> Template {
        let color = randomColor()
        return composed(wrapies: [
            filter(positions: Set(scheme.positionsFor(value: 4)),
            color),
            
            filter(positions: Set(scheme.positionsFor(value: 3)),
            randomPosition(probability: 0.5,
            color))
        ])
    }
    
    private func makeSkeleton() -> Template {
        filter(positions: Set(scheme.positionsFor(value: 2)),
        color(.black))
    }
}
