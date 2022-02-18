//
//  Created by VasiliyKlyotskin
//

import SpriteGeneratorCore

final class ExampleDataSource {
    
    var colorOutput = Table<Color>()
    var width = 16
    var height = 16
    
    private let scheme = Table(values:
    [[0,0,0,0,0,0,0,0],
     [0,0,0,0,0,0,0,0],
     [0,0,0,0,0,0,5,5],
     [0,0,0,0,0,5,1,1],
     [0,0,0,0,0,5,1,2],
     [0,0,0,0,5,1,1,2],
     [0,0,0,0,5,1,1,2],
     [0,0,0,5,1,1,1,2],
     [0,0,5,1,1,1,1,4],
     [0,0,5,1,1,1,3,4],
     [0,0,5,1,1,1,3,4],
     [0,0,5,1,1,1,1,2],
     [0,0,0,5,5,1,1,1],
     [0,0,0,0,0,5,5,5],
     [0,0,0,0,0,0,0,0],
     [0,0,0,0,0,0,0,0]])!
    

    func generateColors() {
        colorOutput = Table(xSize: width, ySize: height, value: Color())
        let generator = SpriteGenerator(colorOutput: colorOutput)
        let template = makeTemplate()
        generator.generate(from: template)
    }
    
    typealias Scheme = Table<Int>
    typealias T = Template

    private func makeTemplate() -> Template {
        let outliner = shipOutline()
        let skeleton = skeleton()
        return composed(wrapies: [
            skeleton,
            cockpit(),
            outline(outliner: outliner,
            body()),
            background()
        ])
    }
    
    private func skeleton() -> Template {
        colorRedirect(from:
        verticalMirror(offset: 16,
        filter(positions: Set(scheme.positionsFor(value: 2)),
        outlineColor)),
        to: outlineColor)
    }

    // MARK: Body
    
    private func body() -> Template {
        randomChoosed([
            (commonBody(), 0.75),
            (rareBody(), 0.23),
            (epicBody(), 0.02)
        ])
    }
    
    private func commonBody() -> Template {
        lighten(body:
        standardBody(colorBody:
        linearGradient(startPoint: Point(x: 0, y: 15), endPoint: Point(x: 15, y: 0), keyPoints: [
            (randomColor(), 0.2),
            (randomColor(), 0.6),
        ])))
    }
    
    private func rareBody() -> Template {
        let grad = linearGradient(startPoint: Point(x: 0, y: 0), endPoint: Point(x: 15, y: 15), keyPoints: [
            (randomColor(), 0.2),
            (randomColor(), 0.8)
        ])
        return lighten(body:
        colorRedirect(from:
        standardBody(colorBody: nil),
        to: grad))
    }
    
    private func epicBody() -> Template {
        let grad = linearGradient(startPoint: Point(x: 15, y: 0), endPoint: Point(x: 0, y: 15), keyPoints: [
            (randomColor(), 0.3),
            (randomColorForPosition(), 0.8)
        ])
        return lighten(body:
        colorRedirect(from:
        standardBody(colorBody: nil),
        to: grad))
    }
    
    private func standardBody(colorBody: Template?) -> Template {
        verticalMirror(offset: 16,
        filter(positions: Set(scheme.positionsFor(value: 1)),
        composed(wrapies: [
            randomPosition(probability: 0.5, colorBody ?? color(.red)),
            filter(positions: Set([Position(x: 7, y: 3)]), colorBody ?? color(.red))
        ])))
    }
    
    private func lighten(body: Template) -> Template {
        let darkenBody = brightness(rate: 0, body)
        let mediumBody = brightness(0.45, body)
        let lightenBody = brightness(0.968, body)
        
        let inner = linearGradient(startPoint: Point(x: 0, y: 0), endPoint: Point(x: 15, y: 15), keyPoints: [
            (darkenBody, 0.1),
            (mediumBody, 0.65)
        ])
        
        return linearGradient(startPoint: Point(x: 11, y: 3), endPoint: Point(x: 3, y: 13), keyPoints: [
            (lightenBody, 0.05),
            (inner, 0.95)
        ])
    }
    
    // MARK: Outline
    
    var outlineColor = color(.black)
    
    private func shipOutline() -> Template {
        randomChoosed([
            (commonOutline(), 0.64),
            (rareOutline(), 0.28),
            (epicOutline(), 0.08)
        ], delegate: OutlineDelegate(shipTemplate: self))
    }
    
    var commonOutlineColor: Template!
    private func commonOutline() -> Template {
        commonOutlineColor = color(.black)
        return commonOutlineColor
    }
    
    var rareOutlineColor: Template!
    private func rareOutline() -> Template {
        let color = brightness(0.1, randomColor())
        let modified =  brightness(0.5, intense(1, color))
        
        rareOutlineColor = linearGradient(startPoint: Point(x: 0, y: 15), endPoint: Point(x: 15, y: 0), keyPoints: [
            (color, 0.4),
            (modified, 0.9)
        ])
        return rareOutlineColor
    }
    
    var epicOutlineColor: Template!
    private func epicOutline() -> Template {
        
        let first = brightness(0.5, intense(1, randomColor()))
        let between = brightness(0.1, randomColor())
        let second =  brightness(0.5, intense(1, randomColor()))
        
        epicOutlineColor = linearGradient(startPoint: Point(x: 0, y: 15), endPoint: Point(x: 15, y: 0), keyPoints: [
            (first, 0.1),
            (between, 0.5),
            (second, 0.9)
        ])
        return epicOutlineColor
    }

    // MARK: Cockpit
    
    private func cockpit() -> Template {
        randomChoosed([
            (commonCockpit(), 0.65),
            (rareCockpit(), 0.35)
        ])
    }
    
    private func commonCockpit() -> Template {
        brightness(0.9,
        randomIntenseForPosition(range: 0.2...0.6,
        verticalMirror(offset: 16,
        cockpit(with: randomColor()))))
    }
    
    private func rareCockpit() -> Template {
        let cockpit = verticalMirror(offset: 16, cockpit(with: randomColor()))
        let intensedCockpit = brightness(0, cockpit)
        return intense(rate: 0.75,
        brightness(rate: 1.5,
        linearGradient(startPoint: Point(x: 5, y: 6), endPoint: Point(x: 15, y: 16), keyPoints: [
            (cockpit, 0),
            (intensedCockpit, 1)
        ])))
    }
    
    private func cockpit(with template: Template) -> Template {
        return composed(wrapies: [
            filter(positions: Set(scheme.positionsFor(value: 4)),
            template),
            
            filter(positions: Set(scheme.positionsFor(value: 3)),
            randomPosition(probability: 0.5,
            template))
        ])
    }

    // MARK: Background
    
    private func background() -> Template {
        intense(rate: 0.8,
        randomChoosed([
            (commonBackground(), 0.8),
            (rareBackground(), 0.17),
            (epicBackground(), 0.03)
        ]))
    }
    
    private func epicBackground() -> Template {
        randomIntenseForPosition(range: 0.07...0.24,
        brightness(0.95,
        randomColorForPosition()))
    }
    
    private func commonBackground() -> Template {
        linearGradient(startPoint: Point(x: 0, y: 0), endPoint: Point(x: 21, y: 21), keyPoints: [
            (rippleComponent(), 0),
            (intense(0.7, brightness(1, randomColor())), 1)
        ])
    }
    
    private func rareBackground() -> Template {
        linearGradient(startPoint: Point(x: -3, y: 18), endPoint: Point(x: 18, y: -3), keyPoints: [
            (edgeComponent(), 0),
            (innerRareBackgroundComponent(), 0.5),
            (edgeComponent(), 1)
        ])
    }
    
    private func innerRareBackgroundComponent() -> Template {
        linearGradient(startPoint: Point(x: -3, y: -3), endPoint: Point(x: 18, y: 18), keyPoints: [
            (edgeComponent(), 0),
            (rippleComponent(), 0.5),
            (edgeComponent(), 1)
        ])
    }
    
    private func rippleComponent() -> Template {
        randomIntenseForPosition(range: 0.1...0.3, brightness(1, randomColor()))
    }
    
    private func edgeComponent() -> Template {
        intense(0.7, brightness(1, randomColor()))
    }
}

// MARK: Delegates

final class OutlineDelegate: RandomChoosedTemplateDelegate {
    
    private let shipTemplate: ExampleDataSource
    
    init(shipTemplate: ExampleDataSource) {
        self.shipTemplate = shipTemplate
    }
    
    func choosed(index: Int, probability: Double) {
        switch index {
        case 0:
            shipTemplate.outlineColor = shipTemplate.commonOutlineColor
        case 1:
            shipTemplate.outlineColor = shipTemplate.rareOutlineColor
        case 2:
            shipTemplate.outlineColor = shipTemplate.epicOutlineColor
        default:
            shipTemplate.outlineColor = color(.black)
        }
    }
    
    func provided(color: Color?, for position: Position) {}
}
