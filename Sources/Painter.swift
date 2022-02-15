//
//  Created by VasiliyKlyotskin
//

protocol Painter {
    func color(for position: Position) -> Color?
}

extension Painter {
    func applied(to position: Position) -> Bool {
        color(for: position) != nil
    }
}
