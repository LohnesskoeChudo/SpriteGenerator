//
//  Created by VasiliyKlyotskin
//

public protocol ColorDelegate {
    func provided(color: Color?, for position: Position)
}

public protocol RandomChosenTemplateDelegate {
    func chosen(index: Int, probability: Double)
}
