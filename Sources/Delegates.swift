//
//  Created by VasiliyKlyotskin
//

public protocol ColorConsumerDelegate {
    func provided(color: Color?, for position: Position)
}

public protocol RandomChoosedTemplateDelegate: ColorConsumerDelegate {
    func choosed(index: Int, probability: Double)
}
