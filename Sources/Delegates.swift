//
//  Created by VasiliyKlyotskin
//

public protocol ColorDelegate {
    func provided(color: Color?, for position: Position)
}

public protocol RandomChoosedTemplateDelegate {
    func choosed(index: Int, probability: Double)
}
