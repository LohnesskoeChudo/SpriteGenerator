//
//  Created by VasiliyKlyotskin
//

public protocol ColorOutput {
    var positionsToOutput: [Position] { get }
    func set(color: Color?, for position: Position)
}

public final class SpriteGenerator {

    private let colorOutput: ColorOutput

    public init(colorOutput: ColorOutput) {
        self.colorOutput = colorOutput
    }
    
    public func generate(from template: Template) {
        let painter = template.painter
        colorOutput.positionsToOutput.forEach {
            colorOutput.set(color: painter.color(for: $0), for: $0)
        }
    }
}
